resource "aws_cloudwatch_event_permission" "OrganizationAccess" {
  principal    = "*"
  statement_id = "OrganizationAccess"

  condition {
    key   = "aws:PrincipalOrgID"
    type  = "StringEquals"
    value = "${aws_organizations_organization.example.id}"
  }
}