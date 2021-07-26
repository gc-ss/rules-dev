resource "aws_apigatewayv2_integration" "example" {
  api_id           = "${aws_apigatewayv2_api.example.id}"
  integration_type = "MOCK"
}