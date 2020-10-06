# User and Roles

locals {
  account_id = data.aws_caller_identity.current.account_id
  users = {
    for u in var.users : u.name => u.roles
  }
  roles = {
    for r in var.roles : r.name => {
      aws_policy   = r.aws_policy
      k8s_policies = r.k8s_policies
    }
  }
}

# Create group with polcy for AWS resource access
resource "aws_iam_group" "access_group" {
  for_each = local.roles

  name = "${var.project}-${each.key}-${var.environment}"
  path = "/users/"
}

data "aws_iam_policy_document" "access_group" {
  for_each = local.roles

  source_json = each.value.aws_policy

  statement {
    sid    = "AssumeRolePolicy"
    effect = "Allow"
    actions = [
      "iam:ListRoles",
      "sts:AssumeRole"
    ]
    resources = [aws_iam_role.access_assumerole[each.key].arn]
  }
}

resource "aws_iam_policy" "access_group" {
  for_each = local.roles

  name        = aws_iam_group.access_group[each.key].name
  description = "Group policy"
  policy      = data.aws_iam_policy_document.access_group[each.key].json
}

resource "aws_iam_group_policy_attachment" "access_group" {
  for_each = local.roles

  group      = aws_iam_group.access_group[each.key].name
  policy_arn = aws_iam_policy.access_group[each.key].arn
}

resource "aws_iam_user_group_membership" "access_user_group" {
  for_each   = local.users
  depends_on = [aws_iam_group.access_group]

  user   = each.key
  groups = [for r in each.value : "${var.project}-${r}-${var.environment}"]
}

# Create assumeroles with policy for Kubernetes aws-auth
resource "aws_iam_role" "access_assumerole" {
  for_each = local.roles

  name               = "${var.project}-kubernetes-${each.key}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.access_assumerole_root_policy.json
  description        = "Assume role for Kubernetes aws-auth"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "access_assumerole_root_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [local.account_id]
    }
  }
}

# Create Kubernetes cluster role and group binding for API access
resource "kubernetes_cluster_role" "access_role" {
  for_each = local.roles

  metadata {
    name = aws_iam_role.access_assumerole[each.key].name
  }

  dynamic "rule" {
    for_each = each.value.k8s_policies
    content {
      verbs      = rule.value.verbs
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
    }
  }
}

resource "kubernetes_cluster_role_binding" "access_role" {
  for_each = local.roles

  metadata {
    name = aws_iam_role.access_assumerole[each.key].name
  }
  subject {
    kind = "Group"
    name = kubernetes_cluster_role.access_role[each.key].metadata.0.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.access_role[each.key].metadata.0.name
  }
}
