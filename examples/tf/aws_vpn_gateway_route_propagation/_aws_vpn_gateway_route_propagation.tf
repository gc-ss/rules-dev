

#---- 0 ----

resource "aws_vpn_gateway_route_propagation" "example" {
  vpn_gateway_id = "${aws_vpn_gateway.example.id}"
  route_table_id = "${aws_route_table.example.id}"
}