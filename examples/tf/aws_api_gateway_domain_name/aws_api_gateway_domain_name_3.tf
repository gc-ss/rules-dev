resource "aws_api_gateway_domain_name" "example" {
  certificate_body          = "${file("${path.module}/example.com/example.crt")}"
  certificate_chain         = "${file("${path.module}/example.com/ca.crt")}"
  certificate_private_key   = "${file("${path.module}/example.com/example.key")}"
  domain_name               = "api.example.com"
  regional_certificate_name = "example-api"

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