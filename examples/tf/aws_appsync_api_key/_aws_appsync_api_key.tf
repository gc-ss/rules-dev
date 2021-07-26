

#---- 0 ----

resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "example"
}

resource "aws_appsync_api_key" "example" {
  api_id  = "${aws_appsync_graphql_api.example.id}"
  expires = "2018-05-03T04:00:00Z"
}