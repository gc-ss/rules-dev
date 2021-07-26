resource "aws_pinpoint_event_stream" "stream" {
  application_id         = "${aws_pinpoint_app.app.application_id}"
  destination_stream_arn = "${aws_kinesis_stream.test_stream.arn}"
  role_arn               = "${aws_iam_role.test_role.arn}"
}

resource "aws_pinpoint_app" "app" {}

resource "aws_kinesis_stream" "test_stream" {
  name        = "pinpoint-kinesis-test"
  shard_count = 1
}

resource "aws_iam_role" "test_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "pinpoint.us-east-1.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "test_role_policy" {
  name = "test_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "kinesis:PutRecords",
      "kinesis:DescribeStream"
    ],
    "Effect": "Allow",
    "Resource": [
      "arn:aws:kinesis:us-east-1:*:*/*"
    ]
  }
}
EOF
}