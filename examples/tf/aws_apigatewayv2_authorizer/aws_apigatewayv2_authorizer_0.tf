resource "aws_apigatewayv2_authorizer" "example" {
  api_id           = "${aws_apigatewayv2_api.example.id}"
  authorizer_type  = "REQUEST"
  authorizer_uri   = "${aws_lambda_function.example.invoke_arn}"
  identity_sources = ["route.request.header.Auth"]
  name             = "example-authorizer"
}