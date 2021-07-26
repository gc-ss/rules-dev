resource "aws_vpc" "example" {
  cidr_block                       = "10.1.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_egress_only_internet_gateway" "example" {
  vpc_id = "${aws_vpc.example.id}"

  tags = {
    Name = "main"
  }
}