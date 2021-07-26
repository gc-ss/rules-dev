

#---- 0 ----

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = "${aws_instance.test.id}"
  port             = 80
}

resource "aws_lb_target_group" "test" {
  // Other arguments
}

resource "aws_instance" "test" {
  // Other arguments
}

#---- 1 ----

resource "aws_lambda_permission" "with_lb" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.test.arn}"
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = "${aws_lb_target_group.test.arn}"
}

resource "aws_lb_target_group" "test" {
  name        = "test"
  target_type = "lambda"
}

resource "aws_lambda_function" "test" {
  // Other arguments
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = "${aws_lambda_function.test.arn}"
  depends_on       = ["aws_lambda_permission.with_lb"]
}