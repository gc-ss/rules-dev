

#---- 0 ----

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.foo.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.foo.id}"
}