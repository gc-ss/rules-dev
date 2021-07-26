

#---- 0 ----

resource "aws_apigatewayv2_integration" "example" {
  api_id           = "${aws_apigatewayv2_api.example.id}"
  integration_type = "MOCK"
}

#---- 1 ----

resource "aws_lambda_function" "example" {
  filename      = "example.zip"
  function_name = "Example"
  role          = "${aws_iam_role.example.arn}"
  handler       = "index.handler"
  runtime       = "nodejs10.x"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id           = "${aws_apigatewayv2_api.example.id}"
  integration_type = "AWS"

  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = "${aws_lambda_function.example.invoke_arn}"
  passthrough_behavior      = "WHEN_NO_MATCH"
}