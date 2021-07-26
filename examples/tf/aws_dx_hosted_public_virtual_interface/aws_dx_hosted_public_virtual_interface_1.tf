resource "aws_dx_hosted_public_virtual_interface" "foo" {
  connection_id = "dxcon-zzzzzzzz"

  name           = "vif-foo"
  vlan           = 4094
  address_family = "ipv4"
  bgp_asn        = 65352

  customer_address = "175.45.176.1/30"
  amazon_address   = "175.45.176.2/30"

  route_filter_prefixes = [
    "210.52.109.0/24",
    "175.45.176.0/22",
  ]
}