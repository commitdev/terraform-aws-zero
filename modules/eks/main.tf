# Set up the terraform provider
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "14.0.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id
  enable_irsa     = true


  node_groups_defaults = {
    ami_type  = var.worker_ami_type
    disk_size = 100
  }

  node_groups = {
    cluster = {
      name = "${var.cluster_name}-eks"

      desired_capacity = var.worker_asg_min_size
      max_capacity     = var.worker_asg_max_size
      min_capacity     = var.worker_asg_min_size

      instance_types = var.worker_instance_types
      capacity_type  = var.use_spot_instances ? "SPOT" : "ON_DEMAND"
      k8s_labels = {
        Environment = var.environment
      }
      additional_tags = {
        Environment = var.environment
      }
    }
  }

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
  cluster_iam_role_name = "k8s-${var.cluster_name}-cluster"
  workers_role_name     = "k8s-${var.cluster_name}-workers"

  # Unfortunately fluentd doesn't yet support oidc auth so we need to grant it to the worker nodes
  workers_additional_policies = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]

  write_kubeconfig = false

  tags = {
    environment = var.environment
  }
}
