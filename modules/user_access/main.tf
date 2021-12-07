# User and Roles

locals {
  account_id = data.aws_caller_identity.current.account_id
  users = {
    for u in var.users : u.name => u.roles
  }
  roles = {
    for r in var.roles : r.name => {
      name       = "${var.project}-${r.name}-${var.environment}"
      aws_policy = r.aws_policy
      k8s_name   = "${var.project}-kubernetes-${r.name}-${var.environment}"
    }
  }
}

# Create group with polcy for AWS resource access
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

resource "aws_iam_group" "access_group" {
  for_each = local.roles

  name = each.value.name
  path = "/users/"
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
  groups = [for r in each.value : aws_iam_group.access_group[r].name]
}
