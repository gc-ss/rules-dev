

#---- 0 ----

# Example CloudWatch log group in us-east-1

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_cloudwatch_log_group" "aws_route53_example_com" {
  provider = "aws.us-east-1"

  name              = "/aws/route53/${aws_route53_zone.example_com.name}"
  retention_in_days = 30
}

# Example CloudWatch log resource policy to allow Route53 to write logs
# to any log group under /aws/route53/*

data "aws_iam_policy_document" "route53-query-logging-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "route53-query-logging-policy" {
  provider = "aws.us-east-1"

  policy_document = "${data.aws_iam_policy_document.route53-query-logging-policy.json}"
  policy_name     = "route53-query-logging-policy"
}

# Example Route53 zone with query logging

resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

resource "aws_route53_query_log" "example_com" {
  depends_on = ["aws_cloudwatch_log_resource_policy.route53-query-logging-policy"]

  cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.aws_route53_example_com.arn}"
  zone_id                  = "${aws_route53_zone.example_com.zone_id}"
}