resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.name}-vpc"
  }
}


module "subnets" {
  source               = "./subnets"

  vpc_id               = aws_vpc.main.id
  subnet_cidr_blocks   = var.subnet_cidr_blocks
  availability_zone    = var.availability_zone
  name                 = var.name
}

module "internet_gateway" {
  source               = "./internet_gateway"

  vpc_id               = aws_vpc.main.id
  name                 = var.name
}

module "route_tables" {
  source               = "./route_tables"

  vpc_id               = aws_vpc.main.id
  internet_gateway_id  = module.internet_gateway.igw_id
  public_subnet_id     = module.subnets.public_subnet_id
  name                 = var.name
}
