resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.us-west-2.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    "${aws_security_group.sg1.id}",
  ]

  private_dns_enabled = true
}