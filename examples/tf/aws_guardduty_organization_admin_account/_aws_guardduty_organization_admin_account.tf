

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