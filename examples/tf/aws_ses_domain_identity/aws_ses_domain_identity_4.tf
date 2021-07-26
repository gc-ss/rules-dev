resource "aws_ses_domain_identity" "example" {
  domain = "example.com"
}

resource "aws_ses_domain_dkim" "example" {
  domain = "${aws_ses_domain_identity.example.domain}"
}

resource "aws_route53_record" "example_amazonses_dkim_record" {
  count   = 3
  zone_id = "ABCDEFGHIJ123"
  name    = "${element(aws_ses_domain_dkim.example.dkim_tokens, count.index)}._domainkey.example.com"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.example.dkim_tokens, count.index)}.dkim.amazonses.com"]
}