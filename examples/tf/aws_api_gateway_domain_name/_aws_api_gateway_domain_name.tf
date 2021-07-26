

#---- 0 ----

resource "aws_api_gateway_domain_name" "example" {
  certificate_arn = "${aws_acm_certificate_validation.example.certificate_arn}"
  domain_name     = "api.example.com"
}

# Example DNS record using Route53.
# Route53 is not specifically required; any DNS host can be used.
resource "aws_route53_record" "example" {
  name    = "${aws_api_gateway_domain_name.example.domain_name}"
  type    = "A"
  zone_id = "${aws_route53_zone.example.id}"

  alias {
    evaluate_target_health = true
    name                   = "${aws_api_gateway_domain_name.example.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.example.cloudfront_zone_id}"
  }
}

#---- 1 ----

resource "aws_api_gateway_domain_name" "example" {
  domain_name = "api.example.com"

  certificate_name        = "example-api"
  certificate_body        = "${file("${path.module}/example.com/example.crt")}"
  certificate_chain       = "${file("${path.module}/example.com/ca.crt")}"
  certificate_private_key = "${file("${path.module}/example.com/example.key")}"
}

# Example DNS record using Route53.
# Route53 is not specifically required; any DNS host can be used.
resource "aws_route53_record" "example" {
  zone_id = "${aws_route53_zone.example.id}" # See aws_route53_zone for how to create this

  name = "${aws_api_gateway_domain_name.example.domain_name}"
  type = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.example.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.example.cloudfront_zone_id}"
    evaluate_target_health = true
  }
}

#---- 2 ----

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

#---- 3 ----

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

#---- 4 ----

resource "aws_api_gateway_deployment" "example" {
  # See aws_api_gateway_rest_api docs for how to create this
  rest_api_id = "${aws_api_gateway_rest_api.MyDemoAPI.id}"
  stage_name  = "live"
}

resource "aws_api_gateway_domain_name" "example" {
  domain_name = "example.com"

  certificate_name        = "example-api"
  certificate_body        = "${file("${path.module}/example.com/example.crt")}"
  certificate_chain       = "${file("${path.module}/example.com/ca.crt")}"
  certificate_private_key = "${file("${path.module}/example.com/example.key")}"
}

resource "aws_api_gateway_base_path_mapping" "test" {
  api_id      = "${aws_api_gateway_rest_api.MyDemoAPI.id}"
  stage_name  = "${aws_api_gateway_deployment.example.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.example.domain_name}"
}