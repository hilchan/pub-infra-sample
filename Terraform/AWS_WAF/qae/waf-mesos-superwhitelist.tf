resource "aws_waf_ipset" "superwhitelist2" {
  name = "superwhitelist2"

  ip_set_descriptors {
	 type = "IPV4"
	 value = "1.2.3.4/32"
	 }
  ip_set_descriptors {
	 type = "IPV4"
	 value = "5.6.7.8/32"
	 }
}
