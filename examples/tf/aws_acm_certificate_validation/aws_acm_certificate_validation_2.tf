resource "aws_acm_certificate" "cert" {
  domain_name       = "example.com"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}