variable "environment" {}

variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_virtual_host" {}

variable "shared_credentials_file" {}

variable "vsphere_datacenter" { default = "XXX Datacenter" }
variable "disk_type" { default = "thin" }
variable "network_label_priv" {}
variable "network_label_pub" {}
variable "folder" {}
variable "application" {default = "MAPP"}
variable "pool" {}
variable "datastore1" {}
variable "datastore2" {}
variable "datastore3" {}
variable "datastore4" {}

variable "domain" { default = "internal.net" }
variable "ns_servers" {}

variable "master_count" {}
variable "master_cpu" {}
variable "master_ram" {}
variable "master_volume_size" {}
variable "master_disk_template" {}

variable "public_slave_count" {}
variable "public_slave_cpu" {}
variable "public_slave_ram" {}
variable "public_volume_size" {}
variable "public_disk_template" {}

variable "private_slave_count" {}
variable "private_slave_cpu" {}
variable "private_slave_ram" {}
variable "private_volume_size" {}
variable "private_disk_template" {}

variable "elk_count" {}
variable "elk_cpu" {}
variable "elk_ram" {}
variable "elk_volume_size" {}
variable "elk_disk_template" {}

variable "ds_count" {}
variable "ds_cpu" {}
variable "ds_ram" {}
variable "ds_volume_size" {}
variable "ds_disk_template" {}
