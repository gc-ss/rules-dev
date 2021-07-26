

#---- 0 ----

resource "aws_apigatewayv2_domain_name" "example" {
  domain_name = "ws-api.example.com"

  domain_name_configuration {
    certificate_arn = "${aws_acm_certificate.example.arn}"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

#---- 1 ----

resource "aws_apigatewayv2_domain_name" "example" {
  domain_name = "http-api.example.com"

  domain_name_configuration {
    certificate_arn = "${aws_acm_certificate.example.arn}"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_route53_record" "example" {
  name    = "${aws_apigatewayv2_domain_name.example.domain_name}"
  type    = "A"
  zone_id = "${aws_route53_zone.example.zone_id}"

  alias {
    name                   = "${aws_apigatewayv2_domain_name.example.domain_name_configuration.0.target_domain_name}"
    zone_id                = "${aws_apigatewayv2_domain_name.example.domain_name_configuration.0.hosted_zone_id}"
    evaluate_target_health = false
  }
}