

#---- 0 ----

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "example" {
  transit_gateway_attachment_id = "${aws_ec2_transit_gateway_peering_attachment.example.id}"

  tags = {
    Name = "Example cross-account attachment"
  }
}