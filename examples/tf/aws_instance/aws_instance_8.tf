resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_instance" "foo" {
  # ... other arguments ...

  depends_on = ["aws_internet_gateway.gw"]
}