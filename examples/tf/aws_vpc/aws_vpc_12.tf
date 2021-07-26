resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_service_discovery_private_dns_namespace" "example" {
  name        = "hoge.example.local"
  description = "example"
  vpc         = "${aws_vpc.example.id}"
}