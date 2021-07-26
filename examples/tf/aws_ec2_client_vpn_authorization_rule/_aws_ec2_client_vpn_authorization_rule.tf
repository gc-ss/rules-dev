

#---- 0 ----

resource "aws_ec2_client_vpn_authorization_rule" "example" {
  client_vpn_endpoint_id = "${aws_ec2_client_vpn_endpoint.example.id}"
  target_network_cidr    = "${aws_subnet.example.cidr_block}"
  authorize_all_groups   = true
}