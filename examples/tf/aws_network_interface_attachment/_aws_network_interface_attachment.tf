

#---- 0 ----

resource "aws_network_interface_attachment" "test" {
  instance_id          = "${aws_instance.test.id}"
  network_interface_id = "${aws_network_interface.test.id}"
  device_index         = 0
}