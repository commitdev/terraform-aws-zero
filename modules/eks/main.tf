# Set up the terraform provider
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

locals {
  k8s_exec_context = "--context ${data.aws_eks_cluster.cluster.name} --server ${data.aws_eks_cluster.cluster.endpoint}"

  # Map this module config to the upstream module config
  eks_node_group_config = { for n, config in var.eks_node_groups :
    n => {
      name = "${var.cluster_name}-${n}"

      desired_capacity = lookup(config, "asg_min_size", 1)
      max_capacity     = lookup(config, "asg_max_size", 3)
      min_capacity     = lookup(config, "asg_min_size", 1)

      create_launch_template  = lookup(config, "use_large_ip_range", true)
      launch_template_version = "1"
      # Hopefully temporary, as there is an issue with the upstream module that leads to this value being non-deterministic with the default of "$Latest"
      # See https://github.com/terraform-aws-modules/terraform-aws-eks/pull/1447

      ami_type           = lookup(config, "ami_type", "AL2_x86_64")
      instance_types     = lookup(config, "instance_types", [])
      capacity_type      = lookup(config, "use_spot_instances", false) ? "SPOT" : "ON_DEMAND"
      disk_size          = 100
      kubelet_extra_args = lookup(config, "use_large_ip_range", true) ? "--max-pods=${lookup(config, "node_ip_limit", 110)}" : ""

      k8s_labels = {
        Environment = var.environment
      }
      additional_tags = {
        Environment = var.environment
      }
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id
  enable_irsa     = true

  node_groups = local.eks_node_group_config

  wait_for_cluster_timeout = 1800 # 30 minutes

  map_roles = concat(
    [{
      rolearn  = "arn:aws:iam::${var.iam_account_id}:role/${var.project}-kubernetes-admin-${var.environment}"
      username = "${var.project}-kubernetes-admin-${var.environment}"
      groups   = ["system:masters"]
    }],
    [
      for r in var.iam_role_mapping : {
        rolearn  = r.iam_role_arn
        username = r.k8s_role_name
        groups   = r.k8s_groups
      }
    ]
  )

  workers_role_name = "k8s-${var.cluster_name}-workers"

  worker_create_cluster_primary_security_group_rules = true

  # Unfortunately fluentd doesn't yet support oidc auth so we need to grant it to the worker nodes
  workers_additional_policies = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]

  write_kubeconfig = false

  tags = {
    environment = var.environment
  }
}

resource "aws_eks_addon" "vpc_cni" {
  count = var.addon_vpc_cni_version == "" ? 0 : 1

  cluster_name      = module.eks.cluster_id
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
  addon_version     = var.addon_vpc_cni_version
}

resource "aws_eks_addon" "kube_proxy" {
  count = var.addon_kube_proxy_version == "" ? 0 : 1

  cluster_name      = module.eks.cluster_id
  addon_name        = "kube-proxy"
  resolve_conflicts = "OVERWRITE"
  addon_version     = var.addon_kube_proxy_version
}

resource "aws_eks_addon" "coredns" {
  count = var.addon_coredns_version == "" ? 0 : 1

  cluster_name      = module.eks.cluster_id
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"
  addon_version     = var.addon_coredns_version
}

# Enable prefix delegation - this will enable many more IPs to be allocated per-node.
# See https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
resource "null_resource" "enable_prefix_delegation" {
  count = var.addon_vpc_cni_version == "" ? 0 : 1

  triggers = {
    manifest_sha1 = sha1(var.addon_vpc_cni_version)
  }

  provisioner "local-exec" {
    command = "kubectl set env daemonset aws-node ${local.k8s_exec_context} -n kube-system ENABLE_PREFIX_DELEGATION=true WARM_PREFIX_TARGET=1"
  }

  depends_on = [aws_eks_addon.vpc_cni]
}
