# provider core reqs
variable "account_id" {}
variable "aws_profile" {}
variable "region" {}
variable "shared_credentials_file" {}

# convenience
variable "keypair" {}

# remote states
variable "tf_s3_bucket" {}
variable "tf_s3_key" {}

# environment
variable "environment" {}
variable "r53_zone" {
  default = "ZxxAD1NKSxxx"
}
variable "stack" {}

# cidrs in use
variable "vpc_main" {}
variable "public_subnet_cidr_a" {}
variable "public_subnet_cidr_b" {}
variable "public_subnet_cidr_c" {}
variable "private_subnet_cidr_a" {}
variable "private_subnet_cidr_b" {}
variable "private_subnet_cidr_c" {}
variable "dmz_cidr_a" {}
variable "dmz_cidr_b" {}
variable "dmz_cidr_c" {}
variable "ol_vpn_pool" {}
