resource "aws_ram_resource_association" "example" {
  resource_arn       = "${aws_subnet.example.arn}"
  resource_share_arn = "${aws_ram_resource_share.example.arn}"
}