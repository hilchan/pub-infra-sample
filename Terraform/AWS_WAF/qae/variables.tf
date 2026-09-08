# convenience
variable "keypair" {}
variable "generic_owner" {}
variable "region_azs" {}

# environment
variable "region" {}
variable "aws_profile" {}
variable "environment" {}
variable "stack" {}
variable "shared_credentials_file" {}
variable "business_unit" {}

# remote states
variable "tf_s3_bucket" {}

# cidrs in use
variable "cidr_prdcton" {}
variable "cidr_staging" {}
variable "cidr_qatestg" {}
variable "cidr_devment" {}
variable "cidr_prdshrd" {}
variable "cidr_devshrd" {}
variable "cidr_vpn_110" {}
variable "cidr_vpn_111" {}
variable "cidr_vpn_112" {}
variable "cidr_vpn_cgw" {}

# VPC
variable "qae_vpc" {}
