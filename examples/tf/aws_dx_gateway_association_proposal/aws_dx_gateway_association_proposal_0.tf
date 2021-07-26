resource "aws_dx_gateway_association_proposal" "example" {
  dx_gateway_id               = "${aws_dx_gateway.example.id}"
  dx_gateway_owner_account_id = "${aws_dx_gateway.example.owner_account_id}"
  associated_gateway_id       = "${aws_vpn_gateway.example.id}"
}