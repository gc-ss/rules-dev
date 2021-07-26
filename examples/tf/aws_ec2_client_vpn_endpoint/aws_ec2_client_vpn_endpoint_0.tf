resource "aws_ec2_client_vpn_route" "example" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.example.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.example.subnet_id
}

resource "aws_ec2_client_vpn_network_association" "example" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.example.id
  subnet_id              = aws_subnet.example.id
}

resource "aws_ec2_client_vpn_endpoint" "example" {
  description            = "Example Client VPN endpoint"
  server_certificate_arn = aws_acm_certificate.example.arn
  client_cidr_block      = "10.0.0.0/16"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.example.arn
  }

  connection_log_options {
    enabled = false
  }
}