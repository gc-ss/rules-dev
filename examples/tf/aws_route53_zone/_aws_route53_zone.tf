

#---- 0 ----

resource "aws_route53_delegation_set" "main" {
  reference_name = "DynDNS"
}

resource "aws_route53_zone" "primary" {
  name              = "hashicorp.com"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_zone" "secondary" {
  name              = "terraform.io"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

#---- 1 ----

resource "aws_vpc" "primary" {
  cidr_block           = "10.6.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_vpc" "secondary" {
  cidr_block           = "10.7.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_route53_zone" "example" {
  name = "example.com"

  # NOTE: The aws_route53_zone vpc argument accepts multiple configuration
  #       blocks. The below usage of the single vpc configuration, the
  #       lifecycle configuration, and the aws_route53_zone_association
  #       resource is for illustrative purposes (e.g. for a separate
  #       cross-account authorization process, which is not shown here).
  vpc {
    vpc_id = "${aws_vpc.primary.id}"
  }

  lifecycle {
    ignore_changes = ["vpc"]
  }
}

resource "aws_route53_zone_association" "secondary" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  vpc_id  = "${aws_vpc.secondary.id}"
}

#---- 2 ----

resource "aws_route53_zone" "primary" {
  name = "example.com"
}

#---- 3 ----

resource "aws_route53_zone" "main" {
  name = "example.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.example.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "dev.example.com"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.dev.name_servers.0}",
    "${aws_route53_zone.dev.name_servers.1}",
    "${aws_route53_zone.dev.name_servers.2}",
    "${aws_route53_zone.dev.name_servers.3}",
  ]
}

#---- 4 ----

resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = "${aws_vpc.example.id}"
  }
}

#---- 5 ----

resource "aws_route53_zone" "example" {
  name = "test.example.com"
}

resource "aws_route53_record" "example" {
  allow_overwrite = true
  name            = "test.example.com"
  ttl             = 30
  type            = "NS"
  zone_id         = "${aws_route53_zone.example.zone_id}"

  records = [
    "${aws_route53_zone.example.name_servers.0}",
    "${aws_route53_zone.example.name_servers.1}",
    "${aws_route53_zone.example.name_servers.2}",
    "${aws_route53_zone.example.name_servers.3}",
  ]
}

#---- 6 ----

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