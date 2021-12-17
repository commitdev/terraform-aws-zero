# User and Roles
locals {
  # Standardize the kubernetes role name
  k8s_role_name_format = "%s-kubernetes-%s-%s" # <project_name>-kubernetes-<role_name>-<environment>
}

data "aws_caller_identity" "current" {}

# Create group policy with added access to the corresponding k8s role
data "aws_iam_policy_document" "access_group" {
  # Convert this with a for because terraform doesn't support for_each with list(object)
  for_each = { for r in var.roles : r.name => r }

  source_json = each.value.aws_policy

  # Allow anyone in this group to assume the role that will let them access the correspondingly named role in kubernetes
  statement {
    sid    = "AssumeRolePolicy"
    effect = "Allow"
    actions = [
      "iam:ListRoles",
      "sts:AssumeRole"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${format(local.k8s_role_name_format, var.project, each.value.name, var.environment)}"]
  }
}

resource "aws_iam_group" "access_group" {
  for_each = { for r in var.roles : r.name => r }

  name = "${var.project}-${each.value.name}-${var.environment}"
  path = "/users/"
}

resource "aws_iam_policy" "access_group" {
  for_each = { for r in var.roles : r.name => r }

  name        = aws_iam_group.access_group[each.key].name
  description = "Group policy"
  policy      = data.aws_iam_policy_document.access_group[each.key].json
}

resource "aws_iam_group_policy_attachment" "access_group" {
  for_each = { for r in var.roles : r.name => r }

  group      = aws_iam_group.access_group[each.key].name
  policy_arn = aws_iam_policy.access_group[each.key].arn
}

resource "aws_iam_user_group_membership" "access_user_group" {
  for_each   = { for u in var.users : u.name => u }
  depends_on = [aws_iam_group.access_group]

  user   = each.value.name
  groups = [for r in each.value.roles : aws_iam_group.access_group[r].name]
}
