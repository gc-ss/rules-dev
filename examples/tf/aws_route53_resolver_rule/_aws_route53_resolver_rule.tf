

#---- 0 ----

resource "aws_route53_resolver_rule" "sys" {
  domain_name = "subdomain.example.com"
  rule_type   = "SYSTEM"
}

#---- 1 ----

resource "aws_route53_resolver_rule" "fwd" {
  domain_name          = "example.com"
  name                 = "example"
  rule_type            = "FORWARD"
  resolver_endpoint_id = "${aws_route53_resolver_endpoint.foo.id}"

  target_ip {
    ip = "123.45.67.89"
  }

  tags {
    Environment = "Prod"
  }
}