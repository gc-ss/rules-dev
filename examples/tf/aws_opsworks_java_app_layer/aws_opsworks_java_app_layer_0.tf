resource "aws_opsworks_java_app_layer" "app" {
  stack_id = "${aws_opsworks_stack.main.id}"
}