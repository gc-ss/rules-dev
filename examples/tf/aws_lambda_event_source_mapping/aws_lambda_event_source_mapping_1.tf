resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = "${aws_kinesis_stream.example.arn}"
  function_name     = "${aws_lambda_function.example.arn}"
  starting_position = "LATEST"
}