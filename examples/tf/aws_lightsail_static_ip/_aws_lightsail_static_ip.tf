

#---- 0 ----

resource "aws_lightsail_static_ip" "test" {
  name = "example"
}

#---- 1 ----

resource "aws_lightsail_static_ip_attachment" "test" {
  static_ip_name = "${aws_lightsail_static_ip.test.id}"
  instance_name  = "${aws_lightsail_instance.test.id}"
}

resource "aws_lightsail_static_ip" "test" {
  name = "example"
}

resource "aws_lightsail_instance" "test" {
  name              = "example"
  availability_zone = "us-east-1b"
  blueprint_id      = "string"
  bundle_id         = "string"
  key_pair_name     = "some_key_name"
}