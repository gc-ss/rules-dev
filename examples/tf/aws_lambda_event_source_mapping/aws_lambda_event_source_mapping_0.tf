resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = "${aws_dynamodb_table.example.stream_arn}"
  function_name     = "${aws_lambda_function.example.arn}"
  starting_position = "LATEST"
}