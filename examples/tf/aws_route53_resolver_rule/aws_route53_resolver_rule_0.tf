resource "aws_route53_resolver_rule" "sys" {
  domain_name = "subdomain.example.com"
  rule_type   = "SYSTEM"
}