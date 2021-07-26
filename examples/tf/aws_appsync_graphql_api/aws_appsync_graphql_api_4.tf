resource "aws_appsync_graphql_api" "example" {
  authentication_type = "OPENID_CONNECT"
  name                = "example"

  openid_connect_config {
    issuer = "https://example.com"
  }
}