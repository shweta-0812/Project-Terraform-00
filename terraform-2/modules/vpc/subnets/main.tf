resource "aws_subnet" "public" {
  vpc_id                    = var.vpc_id
  cidr_block                = var.subnet_cidr_blocks[0]["cidr"]

  map_public_ip_on_launch   = true
  availability_zone         = var.availability_zone

  tags = {
    Name = "${var.name}-${var.subnet_cidr_blocks[1]["tag_name"]}-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_blocks[1]["cidr"]
  availability_zone       = var.availability_zone

  tags = {
    Name = "${var.name}-${var.subnet_cidr_blocks[1]["tag_name"]}-subnet"
  }
}
