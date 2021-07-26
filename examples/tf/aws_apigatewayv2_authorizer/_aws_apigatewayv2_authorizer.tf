

#---- 0 ----

resource "aws_apigatewayv2_authorizer" "example" {
  api_id           = "${aws_apigatewayv2_api.example.id}"
  authorizer_type  = "REQUEST"
  authorizer_uri   = "${aws_lambda_function.example.invoke_arn}"
  identity_sources = ["route.request.header.Auth"]
  name             = "example-authorizer"
}

#---- 1 ----

resource "aws_apigatewayv2_authorizer" "example" {
  api_id           = "${aws_apigatewayv2_api.example.id}"
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "example-authorizer"

  jwt_configuration {
    audience = ["example"]
    issuer   = "https://${aws_cognito_user_pool.example.endpoint}"
  }
}