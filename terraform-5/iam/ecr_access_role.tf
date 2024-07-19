resource "aws_iam_role" "ecr_access_role" {
  name               = var.ecr_assume_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      },
    ]
  })
}
