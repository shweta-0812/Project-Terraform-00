provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../modules/vpc"

  cidr_block = ""
  public_subnet_cidr = ""
  private_subnet_cidr = ""
  availability_zone = "ap-south-1"
  name = "production"
}
