

#---- 0 ----

resource "aws_route53_resolver_endpoint" "foo" {
  name      = "foo"
  direction = "INBOUND"

  security_group_ids = [
    "${aws_security_group.sg1.id}",
    "${aws_security_group.sg2.id}",
  ]

  ip_address {
    subnet_id = "${aws_subnet.sn1.id}"
  }

  ip_address {
    subnet_id = "${aws_subnet.sn2.id}"
    ip        = "10.0.64.4"
  }

  tags {
    Environment = "Prod"
  }
}