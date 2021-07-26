resource "aws_wafregional_ipset" "ipset" {
  name = "tfIPSet"

  ip_set_descriptor {
    type  = "IPV4"
    value = "192.0.7.0/24"
  }

  ip_set_descriptor {
    type  = "IPV4"
    value = "10.16.16.0/16"
  }
}