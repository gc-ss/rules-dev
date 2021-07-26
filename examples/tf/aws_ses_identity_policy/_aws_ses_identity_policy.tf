

#---- 0 ----

resource "aws_ses_domain_identity" "example" {
  domain = "example.com"
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["SES:SendEmail", "SES:SendRawEmail"]
    resources = ["${aws_ses_domain_identity.example.arn}"]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
}

resource "aws_ses_identity_policy" "example" {
  identity = "${aws_ses_domain_identity.example.arn}"
  name     = "example"
  policy   = "${data.aws_iam_policy_document.example.json}"
}