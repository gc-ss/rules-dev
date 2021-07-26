

#---- 0 ----

resource "aws_iam_user" "example" {
  name          = "example"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "example" {
  user    = "${aws_iam_user.example.name}"
  pgp_key = "keybase:some_person_that_exists"
}

output "password" {
  value = "${aws_iam_user_login_profile.example.encrypted_password}"
}

#---- 1 ----

resource "aws_iam_user_login_profile" "example" {
  # ... other configuration ...

  lifecycle {
    ignore_changes = ["password_length", "password_reset_required", "pgp_key"]
  }
}