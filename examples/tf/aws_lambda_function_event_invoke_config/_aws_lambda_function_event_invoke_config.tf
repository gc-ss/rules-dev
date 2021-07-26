

#---- 0 ----

resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_alias.example.function_name

  destination_config {
    on_failure {
      destination = aws_sqs_queue.example.arn
    }

    on_success {
      destination = aws_sns_topic.example.arn
    }
  }
}

#---- 1 ----

resource "aws_lambda_function_event_invoke_config" "example" {
  function_name                = aws_lambda_alias.example.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
}

#---- 2 ----

resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_alias.example.function_name
  qualifier     = aws_lambda_alias.example.name

  # ... other configuration ...
}

#---- 3 ----

resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.example.function_name
  qualifier     = "$LATEST"

  # ... other configuration ...
}

#---- 4 ----

resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.example.function_name
  qualifier     = aws_lambda_function.example.version

  # ... other configuration ...
}