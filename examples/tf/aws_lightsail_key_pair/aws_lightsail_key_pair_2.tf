resource "aws_lightsail_key_pair" "lg_key_pair" {
  name       = "importing"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}