resource "aws_apigatewayv2_route_response" "example" {
  api_id             = "${aws_apigatewayv2_api.example.id}"
  route_id           = "${aws_apigatewayv2_route.example.id}"
  route_response_key = "$default"
}