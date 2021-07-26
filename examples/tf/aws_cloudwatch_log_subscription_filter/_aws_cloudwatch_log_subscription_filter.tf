

#---- 0 ----

resource "aws_cloudwatch_log_subscription_filter" "test_lambdafunction_logfilter" {
  name            = "test_lambdafunction_logfilter"
  role_arn        = "${aws_iam_role.iam_for_lambda.arn}"
  log_group_name  = "/aws/lambda/example_lambda_name"
  filter_pattern  = "logtype test"
  destination_arn = "${aws_kinesis_stream.test_logstream.arn}"
  distribution    = "Random"
}