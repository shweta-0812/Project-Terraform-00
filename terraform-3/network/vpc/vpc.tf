locals {
//  name              = "ex-${basename(path.cwd)}"
  name              = "test-vpc"

  vpc_cidr          = var.vpc_cidr
  azs               = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Environment     = var.environment_tag
    GithubRepo      = var.github_repo
  }
}

data "aws_availability_zones" "available" {}


################################################################################
# VPC Module
################################################################################

module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "5.9.0"

  name                = local.name
  cidr                = local.vpc_cidr

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
  intra_subnets       = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 20)]

  private_subnet_names = ["Private Subnet One", "Private Subnet Two"]
  # public_subnet_names commented to show default name generation for all three subnets
  # private_subnet_names = ["Public Subnet One", "Public Subnet Two", "Public Subnet Three"]
  database_subnet_names    = ["DB Subnet One"]
  intra_subnet_names       = []

  create_database_subnet_group  = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  # Allows instances to have DNS names assigned to them
  enable_dns_hostnames = true
  # Ensures that instances can resolve public DNS hostnames to IP addresses and vice versa
  enable_dns_support   = true

  # Single NAT Gateway for all subnets
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  #  Manages secure communication between your VPC and other networks, such as your on-premises network or another VPC in a different AWS account or region.
  #  enable_vpn_gateway = true

  ## DHCP (Dynamic Host Configuration Protocol) Options
  # enable_dhcp_options              = true
  # dhcp_options_domain_name         = "service.consul"
  # dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # # VPC Flow Logs Options
  # vpc_flow_log_iam_role_name            = "vpc-flow-log-role"
  # vpc_flow_log_iam_role_use_name_prefix = false
  # enable_flow_log                       = true
  # create_flow_log_cloudwatch_log_group  = true
  # create_flow_log_cloudwatch_iam_role   = true
  # flow_log_max_aggregation_interval     = 60

  tags = local.tags
}

//module "vpc_endpoints" {
//  source = "./vpc_endpoints"
//}

//module "identity_manager" {
//  source = "../identity_manager
//}


################################################################################
# Supporting Resources
################################################################################
