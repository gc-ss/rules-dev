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