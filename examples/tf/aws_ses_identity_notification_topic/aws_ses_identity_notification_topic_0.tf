resource "aws_ses_identity_notification_topic" "test" {
  topic_arn                = "${aws_sns_topic.example.arn}"
  notification_type        = "Bounce"
  identity                 = "${aws_ses_domain_identity.example.domain}"
  include_original_headers = true
}