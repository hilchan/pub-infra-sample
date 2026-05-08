terraform {
  required_version = "> 0.9.0"
}

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "sjcvcenter.mm-corp.net"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "mesos-masters" {
  name   = "${var.environment}-${var.application}-master-${format("%02d", count.index+1)}"
  folder = "${var.folder}"
  vcpu   = "${var.master_cpu}"
  memory = "${var.master_ram}"
  dns_servers = "${var.ns_servers}"
  domain = "${var.domain}"
  dns_suffixes = ["mm-corp.net"]
  datacenter = "${var.vsphere_datacenter}"
  resource_pool = "${var.pool}"

  # OS Disk Template
  disk {
    datastore = "${var.datastore1}"
    template = "${var.master_disk_template}"
    type = "${var.disk_type}"
  }

  # Extra disk
  disk {
    size = "${var.master_volume_size}"
    datastore = "${var.datastore1}"
    name   = "${var.application}-master-disk2-${format("%02d", count.index+1)}"
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

  count = "${var.master_count}"
}
