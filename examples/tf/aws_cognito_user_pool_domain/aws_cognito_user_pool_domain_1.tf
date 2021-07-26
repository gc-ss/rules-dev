resource "aws_cognito_user_pool_domain" "main" {
  domain       = "example-domain"
  user_pool_id = "${aws_cognito_user_pool.example.id}"
}

resource "aws_cognito_user_pool" "example" {
  name = "example-pool"
}