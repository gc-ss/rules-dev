

#---- 0 ----

resource "aws_api_gateway_request_validator" "example" {
  name                        = "example"
  rest_api_id                 = "${aws_api_gateway_rest_api.example.id}"
  validate_request_body       = true
  validate_request_parameters = true
}