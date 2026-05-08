terraform {
  required_version = "> 0.9.0"
}

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_virtual_host}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "XXXX-ds" {
  name   = "${var.environment}-${var.application}-ds-${format("%02d", count.index+1)}"
  folder = "${var.folder}"
  vcpu   = "${var.ds_cpu}"
  memory = "${var.ds_ram}"
  dns_suffixes = ["mm-corp.net"]
  dns_servers = "${var.ns_servers}"
  domain = "${var.domain}"
  datacenter = "${var.vsphere_datacenter}"
  resource_pool = "${var.pool}"

  # OS Disk Template
  disk {
    datastore = "${var.datastore3}"
    template = "${var.ds_disk_template}"
    type = "${var.disk_type}"
  }

  # Extra disk
  disk {
    size = "${var.ds_volume_size}"
    datastore = "${var.datastore2}"
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

  count = "${var.ds_count}"
}
