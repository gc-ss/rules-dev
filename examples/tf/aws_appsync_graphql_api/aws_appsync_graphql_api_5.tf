resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "example"

  additional_authentication_provider {
    authentication_type = "AWS_IAM"
  }
}