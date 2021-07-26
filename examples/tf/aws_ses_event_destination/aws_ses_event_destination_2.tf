resource "aws_ses_event_destination" "sns" {
  name                   = "event-destination-sns"
  configuration_set_name = "${aws_ses_configuration_set.example.name}"
  enabled                = true
  matching_types         = ["bounce", "send"]

  sns_destination {
    topic_arn = "${aws_sns_topic.example.arn}"
  }
}