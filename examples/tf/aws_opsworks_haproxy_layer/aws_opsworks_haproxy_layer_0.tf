resource "aws_opsworks_haproxy_layer" "lb" {
  stack_id       = "${aws_opsworks_stack.main.id}"
  stats_password = "foobarbaz"
}