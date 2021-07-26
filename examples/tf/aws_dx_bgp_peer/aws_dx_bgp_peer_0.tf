resource "aws_dx_bgp_peer" "peer" {
  virtual_interface_id = "${aws_dx_private_virtual_interface.foo.id}"
  address_family       = "ipv6"
  bgp_asn              = 65351
}