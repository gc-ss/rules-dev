resource "aws_quicksight_user" "example" {
  user_name     = "an-author"
  email         = "author@example.com"
  identity_type = "IAM"
  user_role     = "AUTHOR"
}