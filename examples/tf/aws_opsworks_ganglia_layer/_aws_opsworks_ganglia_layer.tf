

#---- 0 ----

resource "aws_opsworks_ganglia_layer" "monitor" {
  stack_id = "${aws_opsworks_stack.main.id}"
  password = "foobarbaz"
}