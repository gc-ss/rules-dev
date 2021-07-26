

#---- 0 ----

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
}

#---- 1 ----

resource "aws_dx_gateway" "example" {
  name            = "example"
  amazon_side_asn = "64512"
}

resource "aws_ec2_transit_gateway" "example" {}

resource "aws_dx_gateway_association" "example" {
  dx_gateway_id         = "${aws_dx_gateway.example.id}"
  associated_gateway_id = "${aws_ec2_transit_gateway.example.id}"

  allowed_prefixes = [
    "10.255.255.0/30",
    "10.255.255.8/30",
  ]
}

#---- 2 ----

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

#---- 3 ----

provider "aws" {
  # Creator's credentials.
}

provider "aws" {
  alias = "accepter"

  # Accepter's credentials.
}

data "aws_caller_identity" "accepter" {
  provider = "aws.accepter"
}

# Creator's side of the VIF
resource "aws_dx_hosted_transit_virtual_interface" "creator" {
  connection_id    = "dxcon-zzzzzzzz"
  owner_account_id = "${data.aws_caller_identity.accepter.account_id}"

  name           = "tf-transit-vif-example"
  vlan           = 4094
  address_family = "ipv4"
  bgp_asn        = 65352

  # The aws_dx_hosted_transit_virtual_interface
  # must be destroyed before the aws_dx_gateway.
  depends_on = ["aws_dx_gateway.example"]
}

# Accepter's side of the VIF.
resource "aws_dx_gateway" "example" {
  provider = "aws.accepter"

  name            = "tf-dxg-example"
  amazon_side_asn = 64512
}

resource "aws_dx_hosted_transit_virtual_interface_accepter" "accepter" {
  provider             = "aws.accepter"
  virtual_interface_id = "${aws_dx_hosted_transit_virtual_interface.creator.id}"
  dx_gateway_id        = "${aws_dx_gateway.example.id}"

  tags = {
    Side = "Accepter"
  }
}

#---- 4 ----

resource "aws_dx_gateway" "example" {
  name            = "tf-dxg-example"
  amazon_side_asn = "64512"
}

#---- 5 ----

resource "aws_dx_gateway" "example" {
  name            = "tf-dxg-example"
  amazon_side_asn = 64512
}

resource "aws_dx_transit_virtual_interface" "example" {
  connection_id = "${aws_dx_connection.example.id}"

  dx_gateway_id  = "${aws_dx_gateway.example.id}"
  name           = "tf-transit-vif-example"
  vlan           = 4094
  address_family = "ipv4"
  bgp_asn        = 65352
}