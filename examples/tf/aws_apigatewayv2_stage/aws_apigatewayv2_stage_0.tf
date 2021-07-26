resource "aws_apigatewayv2_stage" "example" {
  api_id = "${aws_apigatewayv2_api.example.id}"
  name   = "example-stage"
}