resource "aws_opsworks_static_web_layer" "web" {
  stack_id = "${aws_opsworks_stack.main.id}"
}