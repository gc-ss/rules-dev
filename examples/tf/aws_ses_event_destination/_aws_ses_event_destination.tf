

#---- 0 ----

resource "aws_ses_event_destination" "cloudwatch" {
  name                   = "event-destination-cloudwatch"
  configuration_set_name = "${aws_ses_configuration_set.example.name}"
  enabled                = true
  matching_types         = ["bounce", "send"]

  cloudwatch_destination {
    default_value  = "default"
    dimension_name = "dimension"
    value_source   = "emailHeader"
  }
}

#---- 1 ----

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

#---- 2 ----

resource "aws_ses_event_destination" "sns" {
  name                   = "event-destination-sns"
  configuration_set_name = "${aws_ses_configuration_set.example.name}"
  enabled                = true
  matching_types         = ["bounce", "send"]

  sns_destination {
    topic_arn = "${aws_sns_topic.example.arn}"
  }
}