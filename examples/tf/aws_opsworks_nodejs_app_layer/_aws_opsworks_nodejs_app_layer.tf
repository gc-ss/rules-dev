

#---- 0 ----

resource "aws_opsworks_nodejs_app_layer" "app" {
  stack_id = "${aws_opsworks_stack.main.id}"
}