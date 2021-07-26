

#---- 0 ----

resource "aws_codebuild_source_credential" "example" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = "example"
}

#---- 1 ----

resource "aws_codebuild_source_credential" "example" {
  auth_type   = "BASIC_AUTH"
  server_type = "BITBUCKET"
  token       = "example"
  user_name   = "test-user"
}