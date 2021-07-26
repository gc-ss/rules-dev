resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_alias.example.function_name
  qualifier     = aws_lambda_alias.example.name

  # ... other configuration ...
}