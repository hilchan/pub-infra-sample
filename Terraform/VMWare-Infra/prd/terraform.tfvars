vsphere_user   = "xxxx"
vsphere_server = "xxxx"
vsphere_datacenter = "SJC Datacenter"
vsphere_cluster    = "LF-Staging"
datastore1         = "LF-Staging/LF-Staging-SSD001"
datastore2         = "LF-Staging/LF-Staging-SSD002"
datastore3         = "LF-Staging/LF-Staging-SSD003"

environment       = "stg"

folder = "STG"

shared_credentials_file = "{variable or vault}"

network_label_priv = "VSwitch/private"
network_label_pub = "VSwitch/public"
pool = "LF-Staging"

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
