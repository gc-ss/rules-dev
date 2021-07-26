

#---- 0 ----

resource "aws_apigatewayv2_deployment" "example" {
  api_id      = "${aws_apigatewayv2_route.example.api_id}"
  description = "Example deployment"

  lifecycle {
    create_before_destroy = true
  }
}

#---- 1 ----

resource "aws_apigatewayv2_deployment" "example" {
  api_id      = aws_apigatewayv2_api.example.id
  description = "Example deployment"

  triggers = {
    redeployment = sha1(join(",", list(
      jsonencode(aws_apigatewayv2_integration.example),
      jsonencode(aws_apigatewayv2_route.example),
    )))
  }

  lifecycle {
    create_before_destroy = true
  }
}