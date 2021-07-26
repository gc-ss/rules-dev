resource "aws_ses_event_destination" "kinesis" {
  name                   = "event-destination-kinesis"
  configuration_set_name = "${aws_ses_configuration_set.example.name}"
  enabled                = true
  matching_types         = ["bounce", "send"]

  kinesis_destination {
    stream_arn = "${aws_kinesis_firehose_delivery_stream.example.arn}"
    role_arn   = "${aws_iam_role.example.arn}"
  }
}