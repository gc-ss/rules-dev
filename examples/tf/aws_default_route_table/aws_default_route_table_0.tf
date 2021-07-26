resource "aws_default_route_table" "r" {
  default_route_table_id = "${aws_vpc.foo.default_route_table_id}"

  route {
    # ...
  }

  tags = {
    Name = "default table"
  }
}