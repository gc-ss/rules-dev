

#---- 0 ----

resource "aws_opsworks_mysql_layer" "db" {
  stack_id = "${aws_opsworks_stack.main.id}"
}