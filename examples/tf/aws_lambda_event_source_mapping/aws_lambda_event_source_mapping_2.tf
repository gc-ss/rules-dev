resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = "${aws_sqs_queue.sqs_queue_test.arn}"
  function_name    = "${aws_lambda_function.example.arn}"
}