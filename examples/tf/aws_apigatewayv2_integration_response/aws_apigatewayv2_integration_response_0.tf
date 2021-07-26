resource "aws_apigatewayv2_integration_response" "example" {
  api_id                   = "${aws_apigatewayv2_api.example.id}"
  integration_id           = "${aws_apigatewayv2_integration.example.id}"
  integration_response_key = "/200/"
}