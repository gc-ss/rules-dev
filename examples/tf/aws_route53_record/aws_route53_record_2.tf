resource "aws_api_gateway_domain_name" "example" {
  domain_name              = "api.example.com"
  regional_certificate_arn = "${aws_acm_certificate_validation.example.certificate_arn}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Example DNS record using Route53.
# Route53 is not specifically required; any DNS host can be used.
resource "aws_route53_record" "example" {
  name    = "${aws_api_gateway_domain_name.example.domain_name}"
  type    = "A"
  zone_id = "${aws_route53_zone.example.id}"

  alias {
    evaluate_target_health = true
    name                   = "${aws_api_gateway_domain_name.example.regional_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.example.regional_zone_id}"
  }
}