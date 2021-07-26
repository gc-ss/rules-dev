

#---- 0 ----

resource "aws_apigatewayv2_api_mapping" "example" {
  api_id      = "${aws_apigatewayv2_api.example.id}"
  domain_name = "${aws_apigatewayv2_domain_name.example.id}"
  stage       = "${aws_apigatewayv2_stage.example.id}"
}