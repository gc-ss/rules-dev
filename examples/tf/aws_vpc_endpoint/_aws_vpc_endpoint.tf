

#---- 0 ----

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.us-west-2.s3"
}

#---- 1 ----

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.us-west-2.s3"

  tags = {
    Environment = "test"
  }
}

#---- 2 ----

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.us-west-2.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    "${aws_security_group.sg1.id}",
  ]

  private_dns_enabled = true
}

#---- 3 ----

resource "aws_vpc_endpoint" "ptfe_service" {
  vpc_id            = "${var.vpc_id}"
  service_name      = "${var.ptfe_service}"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    "${aws_security_group.ptfe_service.id}",
  ]

  subnet_ids          = ["${local.subnet_ids}"]
  private_dns_enabled = false
}

data "aws_route53_zone" "internal" {
  name         = "vpc.internal."
  private_zone = true
  vpc_id       = "${var.vpc_id}"
}

resource "aws_route53_record" "ptfe_service" {
  zone_id = "${data.aws_route53_zone.internal.zone_id}"
  name    = "ptfe.${data.aws_route53_zone.internal.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${lookup(aws_vpc_endpoint.ptfe_service.dns_entry[0], "dns_name")}"]
}

#---- 4 ----

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = ["${aws_vpc_endpoint.my_endpoint.prefix_list_id}"]
  from_port         = 0
  security_group_id = "sg-123456"
}

# ...
resource "aws_vpc_endpoint" "my_endpoint" {
  # ...
}

#---- 5 ----

# ...
egress {
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  prefix_list_ids = ["${aws_vpc_endpoint.my_endpoint.prefix_list_id}"]
}

# ...
resource "aws_vpc_endpoint" "my_endpoint" {
  # ...
}