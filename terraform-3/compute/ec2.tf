data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"

  user_data = <<-EOT
    #!/bin/bash
    echo "Hello Terraform!"
  EOT

  tags = {
    Name        = local.name
    Terraform   = "true"
    Environment = "stage"
    GithubRepo  = "dream-walk-terraform"
  }
}

################################################################################
# EC2 Module
################################################################################

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = local.name

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"

  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.private_subnets, 0)

  vpc_security_group_ids      = [module.security_group.security_group_id]

  placement_group             = aws_placement_group.web.id

  associate_public_ip_address = true
  disable_api_stop            = false

  # IAM Role
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  # only one of these can be enabled at a time
  hibernation = true
  # enclave_options_enabled = true

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  enable_volume_tags = false

  # main EBS volume that contains the operating system for the EC2 instance
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  # EBS (Elastic Block Store) - Persistent storage for EC2
  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
      tags = {
        MountPoint = "/mnt/data"
      }
    }
  ]

  tags = local.tags
}

# network_interface option
module "ec2-network-interface" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = "${local.name}-network-interface"

  network_interface = [
    {
      device_index          = 0
      network_interface_id  = aws_network_interface.this.id
      delete_on_termination = false
    }
  ]

  tags = local.tags
}

# metadata_options
module "ec2-metadata-options" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = "${local.name}-metadata-options"

  subnet_id              = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids = [module.security_group.security_group_id]

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }

  tags = local.tags
}


################################################################################
# Supporting Resources
################################################################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "amazon_linux_23" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_placement_group" "web" {
  name     = local.name
  strategy = "cluster"
}

resource "aws_kms_key" "this" {
}

resource "aws_network_interface" "this" {
  subnet_id = element(module.vpc.private_subnets, 0)
}
