

#---- 0 ----

resource "aws_apigatewayv2_route" "example" {
  api_id    = "${aws_apigatewayv2_api.example.id}"
  route_key = "$default"
}