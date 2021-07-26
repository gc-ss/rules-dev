resource "aws_ec2_transit_gateway_route" "example" {
  destination_cidr_block         = "0.0.0.0/0"
  blackhole                      = true
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway.example.association_default_route_table_id}"
}