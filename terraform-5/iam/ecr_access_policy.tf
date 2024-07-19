locals {
  name    = var.ecr_policy_name
  aws_region  = var.aws_region
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "ecr_access_policy" {
  name = local.name

  policy = jsonencode    ({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
        ]
        Resource = "arn:aws:ecr:${local.aws_region}:${data.aws_caller_identity.current.account_id}:repository/${var.ecr_repo_name}"
      },
    ]
  })
}
