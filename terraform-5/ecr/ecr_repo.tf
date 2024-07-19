resource "aws_ecr_repository" "main_ecr_repo" {
  name = var.ecr_repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = var.ecr_repo_name
    Environment = var.environment
  }
}
