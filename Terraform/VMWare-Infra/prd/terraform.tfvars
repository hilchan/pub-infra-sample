vsphere_user   = "user@vsphere.local"
vsphere_server = "vm.domain.net"
vsphere_datacenter = "SJC Datacenter"
vsphere_cluster    = "cc-me"
datastore1         = "cc-me-d/cc-me-d-SSD001"
datastore2         = "cc-me-d/cc-me-d-SSD002"
datastore3         = "cc-me-d/cc-me-d-SSD003"

environment       = "stg"

folder = "STG"

shared_credentials_file = "path-to-vault"

network_label_priv = "VSwitch/PRIVATE"
network_label_pub = "VSwitch/PUBLIC"
pool = "cc-me-d"

master_count = 3
master_volume_size = 110
master_ram        = 32768
master_cpu        = 8

public_slave_count = 5
public_slave_cpu = 16
public_slave_ram = 65536
public_volume_size = 300

private_slave_count = 7
private_slave_cpu = 16
private_slave_ram = 65536
private_volume_size = 300

elk_count = 1
elk_cpu = 16
elk_ram = 65536
elk_volume_size = 850
