# Set up the terraform provider
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

locals {
  # Map this module config to the upstream module config
  eks_node_group_config = { for n, config in var.eks_node_groups :
    n => {
      name = "${var.cluster_name}-${n}"

      desired_capacity = config.asg_min_size
      max_capacity     = config.asg_max_size
      min_capacity     = config.asg_min_size

      ami_type       = config.ami_type
      instance_types = config.instance_types
      capacity_type  = config.use_spot_instances ? "SPOT" : "ON_DEMAND"
      disk_size      = 100

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
