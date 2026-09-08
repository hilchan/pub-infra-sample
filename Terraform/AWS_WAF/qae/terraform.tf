# App stack for Mesos ALB
variable "terraform_version" {
  default = "v0.8.8"
}

provider "aws" {
    region                  = "${var.region}"
    shared_credentials_file = "${var.shared_credentials_file}"
    profile                 = "${var.aws_profile}"
}

resource "aws_security_group" "waf" {
   name = "${lower(var.environment)}-${var.stack}-base"
   vpc_id = "${var.qae_vpc}"
   tags {
     Name      = "${lower(var.environment)}-${var.stack}-waf"
     env       = "${var.environment}"
     owner     = "${var.generic_owner}"
     stack     = "${var.stack}-alb"
     unit      = "${var.business_unit}"
     terraform = "True"
   }
}
