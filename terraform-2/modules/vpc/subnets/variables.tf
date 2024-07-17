variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "A map of subnet types to their CIDR blocks with 10.0.1.0/24 (IP addresses from 10.0.1.0 to 10.0.1.255) for each subnet type"
  type        = list(map(string))
}


variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = string
}

variable "name" {
  description = "The name prefix for the subnets"
  type        = string
}