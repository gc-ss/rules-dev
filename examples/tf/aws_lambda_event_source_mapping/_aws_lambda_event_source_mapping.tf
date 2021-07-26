

#---- 0 ----

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = "${aws_dynamodb_table.example.stream_arn}"
  function_name     = "${aws_lambda_function.example.arn}"
  starting_position = "LATEST"
}

#---- 1 ----

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = "${aws_kinesis_stream.example.arn}"
  function_name     = "${aws_lambda_function.example.arn}"
  starting_position = "LATEST"
}

#---- 2 ----

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = "${aws_sqs_queue.sqs_queue_test.arn}"
  function_name    = "${aws_lambda_function.example.arn}"
}