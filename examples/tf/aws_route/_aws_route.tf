

#---- 0 ----

resource "aws_route" "r" {
  route_table_id            = "rtb-4fbb3ac4"
  destination_cidr_block    = "10.0.1.0/22"
  vpc_peering_connection_id = "pcx-45ff3dc1"
  depends_on                = ["aws_route_table.testing"]
}

#---- 1 ----

resource "aws_vpc" "vpc" {
  cidr_block                       = "10.1.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_egress_only_internet_gateway" "egress" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "r" {
  route_table_id              = "rtb-4fbb3ac4"
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = "${aws_egress_only_internet_gateway.egress.id}"
}