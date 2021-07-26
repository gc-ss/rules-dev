resource "aws_appsync_graphql_api" "example" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = "example"

  user_pool_config {
    aws_region     = "${data.aws_region.current.name}"
    default_action = "DENY"
    user_pool_id   = "${aws_cognito_user_pool.example.id}"
  }
}