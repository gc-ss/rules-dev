resource "aws_ec2_transit_gateway" "example" {}

resource "aws_customer_gateway" "example" {
  bgp_asn    = 65000
  ip_address = "172.0.0.1"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "example" {
  customer_gateway_id = "${aws_customer_gateway.example.id}"
  transit_gateway_id  = "${aws_ec2_transit_gateway.example.id}"
  type                = "${aws_customer_gateway.example.type}"
}