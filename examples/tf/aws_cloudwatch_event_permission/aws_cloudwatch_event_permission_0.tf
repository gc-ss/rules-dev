resource "aws_cloudwatch_event_permission" "DevAccountAccess" {
  principal    = "123456789012"
  statement_id = "DevAccountAccess"
}