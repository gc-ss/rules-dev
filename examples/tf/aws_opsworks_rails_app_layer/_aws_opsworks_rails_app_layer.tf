

#---- 0 ----

resource "aws_opsworks_rails_app_layer" "app" {
  stack_id = "${aws_opsworks_stack.main.id}"
}