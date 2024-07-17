provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../../modules/vpc"

  # pass variable value for modules/vpc/main.tf
  cidr_block = "10.0.0.0/16"
  subnet_cidr_blocks = [
    {
      "cidr" = "10.0.1.0/24",
      "tag_name" ="public"
    },
    {
      "cidr" = "10.0.2.0/24",
      "tag_name" ="private"
    }
  ]

  availability_zone = "ap-south-1"
  name              = "staging"
}
