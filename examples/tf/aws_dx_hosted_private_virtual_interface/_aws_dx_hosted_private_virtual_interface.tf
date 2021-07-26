

#---- 0 ----

resource "aws_dx_hosted_private_virtual_interface" "foo" {
  connection_id = "dxcon-zzzzzzzz"

  name           = "vif-foo"
  vlan           = 4094
  address_family = "ipv4"
  bgp_asn        = 65352
}

#---- 1 ----

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