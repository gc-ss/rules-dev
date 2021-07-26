resource "aws_config_configuration_recorder" "example" {
  # ... other configuration ...
}

resource "aws_lambda_function" "example" {
  # ... other configuration ...
}

resource "aws_lambda_permission" "example" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.example.arn}"
  principal     = "config.amazonaws.com"
  statement_id  = "AllowExecutionFromConfig"
}

resource "aws_config_config_rule" "example" {
  # ... other configuration ...

  source {
    owner             = "CUSTOM_LAMBDA"
    source_identifier = "${aws_lambda_function.example.arn}"
  }

  depends_on = ["aws_config_configuration_recorder.example", "aws_lambda_permission.example"]
}