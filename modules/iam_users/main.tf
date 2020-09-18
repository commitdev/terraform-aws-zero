# IAM User via assume role for EKS related service access
locals {
  role_users = [
    for r in var.iam_roles : {
      name   = r.name
      policy = r.policy
      users = [
        for u in var.iam_users :
        u.name if contains(u.roles, r.name)
      ]
    }
  ]

  role_user_arns = [
    for r in local.role_users : {
      name = r.name
      user_arns = [
        for u in aws_iam_user.access_user :
        u.arn if contains(r.users, trimprefix(u.name, "${var.project}-"))
      ]
    }
  ]
}

# Create users
resource "aws_iam_user" "access_user" {
  count = length(var.iam_users)
  name  = "${var.project}-${var.iam_users[count.index].name}"

  tags = {
    roles = join("/", var.iam_users[count.index].roles)
  }
}

# Create roles for both AWS and Kubernetes aws-iam-authenticator
resource "aws_iam_role" "access_assumerole" {
  count              = length(local.role_users)
  name               = "${var.project}-kubernetes-${local.role_users[count.index].name}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.access_assumerole_policy[count.index].json
  description        = "user IAM role"
}

# Get trust relationship policy to users
data "aws_iam_policy_document" "access_assumerole_policy" {
  count = length(local.role_user_arns)

  # Allow the user to assume this role
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = local.role_user_arns[count.index].user_arns
    }
  }

}

# Create access role policy
resource "aws_iam_role_policy" "access_role_policy" {
  count  = length(local.role_users)
  name   = "${var.project}-${local.role_users[count.index].name}-${var.environment}"
  role   = aws_iam_role.access_assumerole[count.index].id
  policy = local.role_users[count.index].policy
}

# Create cluster role
resource "kubernetes_cluster_role" "access_role" {
  count = length(local.role_users)
  metadata {
    name = local.role_users[count.index].name
  }
  rule {
    verbs      = ["exec", "create"]
    api_groups = [""]
    resources  = ["pods", "pods/exec"]
  }
}

# Create cluster role binding
resource "kubernetes_cluster_role_binding" "access_role" {
  count = length(local.role_users)
  metadata {
    name = local.role_users[count.index].name
  }
  subject {
    kind = "Group"
    name = local.role_users[count.index].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = local.role_users[count.index].name
  }
}
