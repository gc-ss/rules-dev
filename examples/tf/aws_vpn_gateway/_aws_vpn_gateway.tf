

#---- 0 ----

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main"
  }
}

#---- 1 ----

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

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "172.0.0.1"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = true
}

resource "aws_vpn_connection_route" "office" {
  destination_cidr_block = "192.168.10.0/24"
  vpn_connection_id      = "${aws_vpn_connection.main.id}"
}

#---- 4 ----

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "172.0.0.1"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = true
}

#---- 5 ----

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
resource "aws_dx_hosted_private_virtual_interface" "creator" {
  connection_id    = "dxcon-zzzzzzzz"
  owner_account_id = "${data.aws_caller_identity.accepter.account_id}"

  name           = "vif-foo"
  vlan           = 4094
  address_family = "ipv4"
  bgp_asn        = 65352

  # The aws_dx_hosted_private_virtual_interface
  # must be destroyed before the aws_vpn_gateway.
  depends_on = ["aws_vpn_gateway.vpn_gw"]
}

# Accepter's side of the VIF.
resource "aws_vpn_gateway" "vpn_gw" {
  provider = "aws.accepter"
}

resource "aws_dx_hosted_private_virtual_interface_accepter" "accepter" {
  provider             = "aws.accepter"
  virtual_interface_id = "${aws_dx_hosted_private_virtual_interface.creator.id}"
  vpn_gateway_id       = "${aws_vpn_gateway.vpn_gw.id}"

  tags = {
    Side = "Accepter"
  }
}

#---- 6 ----

resource "aws_vpc" "network" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpn_gateway" "vpn" {
  tags = {
    Name = "example-vpn-gateway"
  }
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = "${aws_vpc.network.id}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn.id}"
}