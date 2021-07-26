

#---- 0 ----

resource "aws_ec2_transit_gateway_route_table" "example" {
  transit_gateway_id = "${aws_ec2_transit_gateway.example.id}"
}