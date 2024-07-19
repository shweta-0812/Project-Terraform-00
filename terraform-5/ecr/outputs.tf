output "ecr_repo_name" {
  description = "The name of the ECR repo"
  value       = aws_ecr_repository.main_ecr_repo.name
}

output "ecr_repo_url" {
  description = "The URL of the ECR repo"
  value       = aws_ecr_repository.main_ecr_repo.repository_url
}


output "ecr_repo_arn" {
  description = "The URL of the ECR repo"
  value       = aws_ecr_repository.main_ecr_repo.arn
}
