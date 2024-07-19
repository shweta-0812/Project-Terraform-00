provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source = "./ecr"

  environment = var.environment
  ecr_repo_name = var.ecr_repo_name
}

module "iam" {
  source = "./iam"

  aws_region = var.aws_region
  ecr_assume_role_name = var.ecr_assume_role_name
  ecr_policy_name = var.ecr_policy_name
  ecr_repo_name = var.ecr_repo_name
}
