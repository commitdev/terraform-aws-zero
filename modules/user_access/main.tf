# User and Roles

# Create group with polcy for AWS resource access
resource "aws_iam_group" "access_group" {
  count = length(var.roles)
  name  = "${var.project}-${var.roles[count.index].name}-${var.environment}"
  path  = "/users/"
}

resource "aws_iam_policy" "access_group" {
  count       = length(var.roles)
  name        = aws_iam_group.access_group[count.index].name
  description = "Group policy"
  policy      = var.roles[count.index].aws_policy
}

resource "aws_iam_group_policy_attachment" "access_group" {
  count      = length(var.roles)
  group      = aws_iam_group.access_group[count.index].name
  policy_arn = aws_iam_policy.access_group[count.index].arn
}

resource "aws_iam_user_group_membership" "access_user_group" {
  count  = length(var.users)
  user   = "${var.project}-${var.users[count.index].name}"
  groups = [for r in var.users[count.index].roles : "${var.project}-${r}-${var.environment}"]
}

# Create assumeroles with policy for Kubernetes aws-auth
resource "aws_iam_role" "access_assumerole" {
  count              = length(var.roles)
  name               = "${var.project}-kubernetes-${var.roles[count.index].name}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.access_assumerole_root_policy.json
  description        = "Assume role for Kubernetes aws-auth"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "access_assumerole_root_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
  }
}

# Create Kubernetes cluster role and group binding for API access
resource "kubernetes_cluster_role" "access_role" {
  count = length(var.roles)
  metadata {
    name = aws_iam_role.access_assumerole[count.index].name
  }

  dynamic "rule" {
    for_each = var.roles[count.index].k8s_policies
    content {
      verbs      = rule.value.verbs
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
    }
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
