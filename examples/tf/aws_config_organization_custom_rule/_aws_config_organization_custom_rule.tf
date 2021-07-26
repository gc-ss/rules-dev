

#---- 0 ----

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