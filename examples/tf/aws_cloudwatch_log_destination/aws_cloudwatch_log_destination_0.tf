resource "aws_cloudwatch_log_destination" "test_destination" {
  name       = "test_destination"
  role_arn   = "${aws_iam_role.iam_for_cloudwatch.arn}"
  target_arn = "${aws_kinesis_stream.kinesis_for_cloudwatch.arn}"
}