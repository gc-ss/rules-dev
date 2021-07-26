

#---- 0 ----

resource "aws_opsworks_instance" "my-instance" {
  stack_id = "${aws_opsworks_stack.main.id}"

  layer_ids = [
    "${aws_opsworks_custom_layer.my-layer.id}",
  ]

  instance_type = "t2.micro"
  os            = "Amazon Linux 2015.09"
  state         = "stopped"
}