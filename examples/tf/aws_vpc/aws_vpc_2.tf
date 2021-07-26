resource "aws_dx_gateway" "example" {
  name            = "example"
  amazon_side_asn = "64512"
}

resource "aws_vpc" "example" {
  cidr_block = "10.255.255.0/28"
}

resource "aws_vpn_gateway" "example" {
  vpc_id = "${aws_vpc.example.id}"
}

resource "aws_dx_gateway_association" "example" {
  dx_gateway_id         = "${aws_dx_gateway.example.id}"
  associated_gateway_id = "${aws_vpn_gateway.example.id}"

  allowed_prefixes = [
    "210.52.109.0/24",
    "175.45.176.0/22",
  ]
}