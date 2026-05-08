vsphere_user   = "hXXXX"
vsphere_server = "vcentXXXX"
vsphere_datacenter = "XXXX"
vsphere_cluster    = "v-XXXX"
datastore1         = "ssd-XXXX"
datastore2         = "ssd-XXXX"
datastore3         = "ssd-XXXX"

environment       = "var"

folder = "var"

shared_credentials_file = "var"

network_label_priv = "VSwitch/XXX-PRIVATE"
network_label_pub = "VSwitch/XXX-PUBLIC"
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

elk_count = 1
elk_cpu = 16
elk_ram = 65536
elk_volume_size = 850

ds_count = 2
ds_cpu = 16
ds_ram = 65536
ds_volume_size = 250