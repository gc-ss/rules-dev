resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.example.function_name
  qualifier     = aws_lambda_function.example.version

  # ... other configuration ...
}