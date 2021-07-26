resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.mainvpc.default_network_acl_id}"

  # no rules defined, deny all traffic in this ACL
}