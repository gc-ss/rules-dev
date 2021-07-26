

#---- 0 ----

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_guardduty_detector" "example" {}

resource "aws_guardduty_organization_admin_account" "example" {
  depends_on = [aws_organizations_organization.example]

  admin_account_id = "123456789012"
}

#---- 1 ----

resource "aws_lambda_permission" "example" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.example.arn}"
  principal     = "config.amazonaws.com"
  statement_id  = "AllowExecutionFromConfig"
}

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["config-multiaccountsetup.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_config_organization_custom_rule" "example" {
  depends_on = ["aws_lambda_permission.example", "aws_organizations_organization.example"]

  lambda_function_arn = "${aws_lambda_function.example.arn}"
  name                = "example"
  trigger_types       = ["ConfigurationItemChangeNotification"]
}

#---- 2 ----

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}

#---- 3 ----

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["config-multiaccountsetup.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_config_organization_managed_rule" "example" {
  depends_on = ["aws_organizations_organization.example"]

  name            = "example"
  rule_identifier = "IAM_PASSWORD_POLICY"
}