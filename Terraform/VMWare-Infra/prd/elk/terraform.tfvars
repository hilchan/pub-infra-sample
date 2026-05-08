vsphere_user   = "hchanXXXX"
vsphere_server = "XXXX"
vsphere_datacenter = "SXXXX"
vsphere_cluster    = "XXXX"
datastore1         = "XXXX"
datastore2         = "XXXX"
datastore3         = "XXXX"

environment       = "var"

folder = "var"

shared_credentials_file = "var"

network_label_priv = "PRIVATE"
network_label_pub = "PUBLIC"
pool = "LF-var"

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

elk_count = 3
elk_cpu = 16
elk_ram = 65536
elk_volume_size = 850
