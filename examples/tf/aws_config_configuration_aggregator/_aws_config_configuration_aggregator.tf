

#---- 0 ----

resource "aws_config_configuration_aggregator" "account" {
  name = "example"

  account_aggregation_source {
    account_ids = ["123456789012"]
    regions     = ["us-west-2"]
  }
}

#---- 1 ----

resource "aws_config_configuration_aggregator" "organization" {
  depends_on = ["aws_iam_role_policy_attachment.organization"]

  name = "example" # Required

  organization_aggregation_source {
    all_regions = true
    role_arn    = "${aws_iam_role.organization.arn}"
  }
}

resource "aws_iam_role" "organization" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "organization" {
  role       = "${aws_iam_role.organization.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}