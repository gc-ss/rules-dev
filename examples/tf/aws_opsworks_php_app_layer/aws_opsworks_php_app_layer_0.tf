resource "aws_opsworks_php_app_layer" "app" {
  stack_id = "${aws_opsworks_stack.main.id}"
}