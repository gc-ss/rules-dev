resource "aws_iam_user" "test" {
  name = "test"
  path = "/test/"
}

resource "aws_iam_access_key" "test" {
  user = aws_iam_user.test.name
}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.test.ses_smtp_password_v4
}