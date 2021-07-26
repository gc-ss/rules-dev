

#---- 0 ----

resource "aws_opsworks_memcached_layer" "cache" {
  stack_id = "${aws_opsworks_stack.main.id}"
}