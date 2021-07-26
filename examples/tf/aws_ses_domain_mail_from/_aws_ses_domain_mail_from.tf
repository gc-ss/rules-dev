

#---- 0 ----

resource "aws_ses_domain_mail_from" "example" {
  domain           = "${aws_ses_domain_identity.example.domain}"
  mail_from_domain = "bounce.${aws_ses_domain_identity.example.domain}"
}

# Example SES Domain Identity
resource "aws_ses_domain_identity" "example" {
  domain = "example.com"
}

# Example Route53 MX record
resource "aws_route53_record" "example_ses_domain_mail_from_mx" {
  zone_id = "${aws_route53_zone.example.id}"
  name    = "${aws_ses_domain_mail_from.example.mail_from_domain}"
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.us-east-1.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
}

# Example Route53 TXT record for SPF
resource "aws_route53_record" "example_ses_domain_mail_from_txt" {
  zone_id = "${aws_route53_zone.example.id}"
  name    = "${aws_ses_domain_mail_from.example.mail_from_domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}