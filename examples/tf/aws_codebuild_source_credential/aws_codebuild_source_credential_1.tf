resource "aws_codebuild_source_credential" "example" {
  auth_type   = "BASIC_AUTH"
  server_type = "BITBUCKET"
  token       = "example"
  user_name   = "test-user"
}