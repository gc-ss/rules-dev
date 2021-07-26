

#---- 0 ----

resource "aws_opsworks_custom_layer" "custlayer" {
  name       = "My Awesome Custom Layer"
  short_name = "awesome"
  stack_id   = "${aws_opsworks_stack.main.id}"
}