resource "aws_api_gateway_documentation_version" "example" {
  version     = "example_version"
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  description = "Example description"
  depends_on  = ["aws_api_gateway_documentation_part.example"]
}

resource "aws_api_gateway_rest_api" "example" {
  name = "example_api"
}

resource "aws_api_gateway_documentation_part" "example" {
  location {
    type = "API"
  }

  properties  = "{\"description\":\"Example\"}"
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
}