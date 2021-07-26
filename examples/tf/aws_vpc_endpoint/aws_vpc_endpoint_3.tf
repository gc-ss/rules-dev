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