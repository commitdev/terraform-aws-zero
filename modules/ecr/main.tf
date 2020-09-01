resource "aws_ecr_repository" "ecr_repository" {
  for_each = var.ecr_repositories
  name     = each.value

  tags = {
    environment = var.environment
  }
}

data "aws_iam_policy_document" "ecr_fullaccess" {
  statement {
    sid    = "FullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.ecr_principals
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
    ]
  }
}

resource "aws_ecr_repository_policy" "default" {
  for_each   = var.ecr_repositories
  repository = each.value
  policy     = data.aws_iam_policy_document.ecr_fullaccess.json
  depends_on = [aws_ecr_repository.ecr_repository]
}
