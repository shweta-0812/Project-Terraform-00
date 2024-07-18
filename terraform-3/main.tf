locals {
  region            = "ap-south-1"
  environment_tag   = "staging"
  github_repo        = "Project-Terraform"
}

provider "aws" {
  region = local.region
}


################################################################
######################## VPC ###################################
################################################################
module "vpc" {
  source = "./network/vpc"

  # pass variable value for vpc/main.tf
  vpc_cidr            = "10.0.0.0/16"
  region              = local.region
  environment_tag     = local.environment_tag
  github_repo         = "Project-Terraform"

  subnet_cidr_blocks = [
    {
      "cidr"        = "10.0.1.0/24",
      "tag_name"    = "public"
    },
    {
      "cidr"        = "10.0.2.0/24",
      "tag_name"    = "private"
    }
  ]

}
