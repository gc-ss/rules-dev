resource "aws_opsworks_user_profile" "my_profile" {
  user_arn     = "${aws_iam_user.user.arn}"
  ssh_username = "my_user"
}