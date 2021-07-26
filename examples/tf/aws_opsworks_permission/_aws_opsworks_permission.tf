

#---- 0 ----

resource "aws_opsworks_permission" "my_stack_permission" {
  allow_ssh  = true
  allow_sudo = true
  level      = "iam_only"
  user_arn   = "${aws_iam_user.user.arn}"
  stack_id   = "${aws_opsworks_stack.stack.id}"
}