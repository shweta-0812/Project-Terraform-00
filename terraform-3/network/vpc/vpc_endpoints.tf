################################################################################
# VPC Endpoints Module
################################################################################
module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
}

//module "vpc_endpoints" {
//  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
//
//  # ID of the VPC where the endpoints will be deployed
//  vpc_id = module.vpc.vpc_id
//
//  create_security_group      = true
//  security_group_name_prefix = "${local.name}-vpc-endpoints-"
//  security_group_description = "VPC endpoint security group"
//  security_group_rules = {
//    ingress_https = {
//      description = "HTTPS from VPC"
//      cidr_blocks = [module.vpc.vpc_cidr_block]
//    }
//  }
//
//  endpoints = {
//    s3 = {
//      service             = "s3"
//      private_dns_enabled = true
//      dns_options = {
//        private_dns_only_for_inbound_resolver_endpoint = false
//      }
//      tags = { Name = "s3-vpc-endpoint" }
//    },
//    ecr_api = {
//      service             = "ecr.api"
//      private_dns_enabled = true
//      subnet_ids          = module.vpc.private_subnets
//      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
//    },
//    ecr_dkr = {
//      service             = "ecr.dkr"
//      private_dns_enabled = true
//      subnet_ids          = module.vpc.private_subnets
//      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
//    },
//    rds = {
//      service             = "rds"
//      private_dns_enabled = true
//      subnet_ids          = module.vpc.private_subnets
//      security_group_ids  = [aws_security_group.rds.id]
//    },
//  }
//
//  tags = merge(local.tags, {
//    Project  = "Secret"
//    Endpoint = "true"
//  })
//}
