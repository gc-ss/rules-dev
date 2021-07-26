resource "aws_cloudwatch_log_destination" "test_destination" {
  name       = "test_destination"
  role_arn   = "${aws_iam_role.iam_for_cloudwatch.arn}"
  target_arn = "${aws_kinesis_stream.kinesis_for_cloudwatch.arn}"
}

data "aws_iam_policy_document" "test_destination_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "123456789012",
      ]
    }

    actions = [
      "logs:PutSubscriptionFilter",
    ]

    resources = [
      "${aws_cloudwatch_log_destination.test_destination.arn}",
    ]
  }
}

resource "aws_cloudwatch_log_destination_policy" "test_destination_policy" {
  destination_name = "${aws_cloudwatch_log_destination.test_destination.name}"
  access_policy    = "${data.aws_iam_policy_document.test_destination_policy.json}"
}