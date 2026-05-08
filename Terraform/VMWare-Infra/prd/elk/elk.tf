terraform {
  required_version = "> 0.9.0"
}

// data "terraform_remote_state" "env" {
//   backend = "s3"
//   config {
//     bucket                  = "mm-ops-devshrd/SJC-VM/mesos/qa"
//     key                     = "terraform.tfstate"
//     region                  = "us-west-1"
//     shared_credentials_file = "${var.shared_credentials_file}"
//     profile                 = "mm-dev"
//   }
// }

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "sjcvcenter.mm-corp.net"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "mesos-elk" {
  name   = "${var.environment}-${var.application}-elk-${format("%02d", count.index+1)}"
  folder = "${var.folder}"
  vcpu   = "${var.elk_cpu}"
  memory = "${var.elk_ram}"
  dns_suffixes = ["mm-corp.net"]
  dns_servers = "${var.ns_servers}"
  domain = "${var.domain}"
  datacenter = "${var.vsphere_datacenter}"
  resource_pool = "${var.pool}"

  # OS Disk Template
  disk {
    datastore = "${var.datastore1}"
    template = "${var.elk_disk_template}"
    type = "${var.disk_type}"
  }

  # Extra disk
  disk {
    size = "${var.elk_volume_size}"
    datastore = "${var.datastore1}"
    name   = "${var.environment}-${var.application}-private-disk2-${format("%02d", count.index+1)}"
  }

  network_interface {
    label = "${var.network_label_priv}"
    ipv4_address = ""
  }

  connection {
    type = "ssh"
    user = "provision"
    private_key = "${file("/Users/hchan/.ssh/shane-vm-id_rsa")}"
    host = "${self.network_interface.0.ipv4_address}"
  }

  provisioner "file" {
    source      = "../../scripts/lvmcreate.sh"
    destination = "/tmp/lvmcreate.sh"
  }

  provisioner "remote-exec" {
    inline = [ "chmod +x /tmp/lvmcreate.sh",
	       "cd /tmp",
	       "./lvmcreate.sh /dev/sdb"
	     ]
  }

  count = "${var.elk_count}"
}
