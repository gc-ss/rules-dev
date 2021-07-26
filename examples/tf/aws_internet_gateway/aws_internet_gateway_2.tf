resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_nat_gateway" "gw" {
  # ... other arguments ...

  depends_on = ["aws_internet_gateway.gw"]
}