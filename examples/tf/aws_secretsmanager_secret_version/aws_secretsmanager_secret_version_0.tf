resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = "${aws_secretsmanager_secret.example.id}"
  secret_string = "example-string-to-protect"
}