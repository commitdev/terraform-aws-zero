# User and Roles

# Create group with polcy for AWS resource access
data "aws_iam_policy_document" "access_group" {
  for_each = var.roles

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
  for_each = var.roles

  name = "${var.project}-${each.value.name}-${var.environment}"
  path = "/users/"
}

resource "aws_iam_policy" "access_group" {
  for_each = var.roles

  name        = aws_iam_group.access_group[each.key].name
  description = "Group policy"
  policy      = data.aws_iam_policy_document.access_group[each.key].json
}

resource "aws_iam_group_policy_attachment" "access_group" {
  for_each = var.roles

  group      = aws_iam_group.access_group[each.key].name
  policy_arn = aws_iam_policy.access_group[each.key].arn
}

resource "aws_iam_user_group_membership" "access_user_group" {
  for_each   = var.users
  depends_on = [aws_iam_group.access_group]

  user   = each.value.name
  groups = [for r in each.value.roles : aws_iam_group.access_group[r].name]
}
