variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "region" {
  description = "VPC CIDR"
  type = string
}

variable "environment_tag" {
  description = "VPC CIDR"
  type = string
}

variable "github_repo" {
  description = "VPC CIDR"
  type = string
}

variable "subnet_cidr_blocks" {
  description = "VPC CIDR"
  type = list(map(string))
}
