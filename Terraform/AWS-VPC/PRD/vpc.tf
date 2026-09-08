# Service provider
provider "aws" {
    region                  = "${var.region}"
    shared_credentials_file = "${var.shared_credentials_file}"
    profile                 = "${var.aws_profile}"
    version                 = "~> 1.29"
}

# Backup state file in S3
terraform {
  required_version = ">= 0.11.7"
  backend "s3" {
    bucket = "my-prdshrd2"
    key    = "vpc/prd/vpc-prd.tfstate"
    region = "us-xxxx-2"
    encrypt = "true"
    profile = "my-prod"
  }
}

# Create VPC
resource "aws_vpc" "main"{
  cidr_block       = "${var.vpc_main}"
  instance_tenancy = "default"

  tags {
    Name = "${var.environment}-vpc"
    Terraform = "True"
  }
}


# Define the security group for public subnet
resource "aws_security_group" "corp_ssh" {
  name = "${var.environment} Corp Access"
  description = "Allow incoming & SSH access from Company VPN"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  [
            "${var.ol_vpn_pool}"
            ]
  }

  vpc_id="${aws_vpc.main.id}"

  tags {
    Name = "${var.environment}-Corp-SG"
  }
}

# Create VPN gateway
resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.environment}-vgw"
  }
}
