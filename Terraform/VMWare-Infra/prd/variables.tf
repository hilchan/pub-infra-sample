variable "environment" {}

variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

variable "shared_credentials_file" {}

variable "vsphere_datacenter" { default = "SJC Datacenter" }
variable "disk_type" { default = "thin" }
variable "network_label_priv" {}
variable "network_label_pub" {}
variable "folder" {}
variable "application" {default = "mesos"}
variable "pool" {default = "LF-Staging"}
variable "datastore1" {}
variable "datastore2" {}
variable "datastore3" {}

variable "domain" { default = "mm-corp.net" }
variable "ns_servers" { default = ["10.208.6.10","10.208.6.11"] }

variable "master_count" {}
variable "master_cpu" {}
variable "master_ram" {}
variable "master_volume_size" {}
variable "master_disk_template" { default = "leapfrog-templates/leapfrog-private" }

variable "public_slave_count" {}
variable "public_slave_cpu" {}
variable "public_slave_ram" {}
variable "public_volume_size" {}
variable "public_disk_template" { default = "leapfrog-templates/leapfrog-public" }

variable "private_slave_count" {}
variable "private_slave_cpu" {}
variable "private_slave_ram" {}
variable "private_volume_size" {}
variable "private_disk_template" { default = "leapfrog-templates/leapfrog-private" }

variable "elk_count" {}
variable "elk_cpu" {}
variable "elk_ram" {}
variable "elk_volume_size" {}
variable "elk_disk_template" { default = "leapfrog-templates/leapfrog-private" }
