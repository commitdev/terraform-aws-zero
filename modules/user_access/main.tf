# User and Roles

locals {
  role_users = [
    for r in var.roles : {
      name   = r.name
      policy = r.policy
      users = [
        for u in var.users :
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

  user_groups = [
    for u in var.users : {
      name   = u.name
      groups = [
        for g in aws_iam_group.access_group :
        g.name if contains(u.roles, trimsuffix(trimprefix(g.name, "${var.project}-"), "-${var.environment}"))
      ]
    }
  ]
}

# Create users and groups with polcy for AWS resource access
resource "aws_iam_group" "access_group" {
  count = length(var.roles)
  name  = "${var.project}-${var.roles[count.index].name}-${var.environment}"
  path  = "/users/"
}

resource "aws_iam_policy" "access_group" {
  count       = length(var.roles)
  name        = aws_iam_group.access_group[count.index].name
  description = "Group policy"
  policy      = var.roles[count.index].policy
}

resource "aws_iam_group_policy_attachment" "access_group" {
  count      = length(var.roles)
  group      = aws_iam_group.access_group[count.index].name
  policy_arn = aws_iam_policy.access_group[count.index].arn
}

## Users
resource "aws_iam_user" "access_user" {
  count = length(var.users)
  name  = "${var.project}-${var.users[count.index].name}"

  tags = {
    roles = join("/", var.users[count.index].roles)
  }
}

## User-Group mapping
resource "aws_iam_user_group_membership" "access_user_group" {
  count  = length(var.users)
  user   = aws_iam_user.access_user[count.index].name
  groups = local.user_groups[count.index].groups
}


# Create roles with policy for Kubernetes aws-auth
resource "aws_iam_role" "access_assumerole" {
  count              = length(var.roles)
  name               = "${var.project}-kubernetes-${var.roles[count.index].name}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.access_assumerole_policy[count.index].json
  description        = "Assume role for Kubernetes aws-auth"
}

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

# Create Kubernetes cluster role and group binding for API access
resource "kubernetes_cluster_role" "access_role" {
  count = length(var.roles)
  metadata {
    name = aws_iam_role.access_assumerole[count.index].name
  }
  rule {
    verbs      = ["exec", "create"]
    api_groups = [""]
    resources  = ["pods", "pods/exec"]
  }
}

resource "kubernetes_cluster_role_binding" "access_role" {
  count = length(var.roles)
  metadata {
    name = aws_iam_role.access_assumerole[count.index].name
  }
  subject {
    kind = "Group"
    name = kubernetes_cluster_role.access_role[count.index].metadata.0.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.access_role[count.index].metadata.0.name
  }
}
