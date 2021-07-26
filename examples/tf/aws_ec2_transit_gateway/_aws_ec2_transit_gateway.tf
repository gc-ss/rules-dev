

#---- 0 ----

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

resource "aws_ec2_tag" "example" {
  resource_id = "${aws_vpn_connection.example.transit_gateway_attachment_id}"
  key         = "Name"
  value       = "Hello World"
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

#---- 3 ----

resource "aws_ec2_transit_gateway" "example" {
  description = "example"
}

#---- 4 ----

provider "aws" {
  alias  = "local"
  region = "us-east-1"
}

provider "aws" {
  alias  = "peer"
  region = "us-west-2"
}

data "aws_region" "peer" {
  provider = aws.peer
}

resource "aws_ec2_transit_gateway" "local" {
  provider = aws.local

  tags = {
    Name = "Local TGW"
  }
}

resource "aws_ec2_transit_gateway" "peer" {
  provider = aws.peer

  tags = {
    Name = "Peer TGW"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment" "example" {
  peer_account_id         = aws_ec2_transit_gateway.peer.owner_id
  peer_region             = data.aws_region.peer.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.peer.id
  transit_gateway_id      = aws_ec2_transit_gateway.local.id

  tags = {
    Name = "TGW Peering Requestor"
  }
}