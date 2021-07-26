resource "aws_apigatewayv2_deployment" "example" {
  api_id      = "${aws_apigatewayv2_route.example.api_id}"
  description = "Example deployment"

  lifecycle {
    create_before_destroy = true
  }
}