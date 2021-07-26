data "aws_instance" "instance" {
  instance_id = "i-1234567890abcdef0"
}

resource "aws_security_group" "sg" {
  tags = {
    "type" = "terraform-test-security-group"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.sg.id}"
  network_interface_id = "${data.aws_instance.instance.network_interface_id}"
}