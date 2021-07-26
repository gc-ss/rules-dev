resource "aws_ec2_client_vpn_network_association" "example" {
  client_vpn_endpoint_id = "${aws_ec2_client_vpn_endpoint.example.id}"
  subnet_id              = "${aws_subnet.example.id}"
}