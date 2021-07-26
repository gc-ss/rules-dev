resource "aws_iam_user_login_profile" "example" {
  # ... other configuration ...

  lifecycle {
    ignore_changes = ["password_length", "password_reset_required", "pgp_key"]
  }
}