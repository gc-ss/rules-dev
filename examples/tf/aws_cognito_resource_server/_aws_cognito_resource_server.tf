

#---- 0 ----

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "https://example.com"
  name       = "example"

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

#---- 1 ----

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "https://example.com"
  name       = "example"

  scope {
    scope_name        = "sample-scope"
    scope_description = "a Sample Scope Description"
  }

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}