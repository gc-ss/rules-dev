

#---- 0 ----

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.example.id}"
}

#---- 1 ----

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.example.id}"

  tags = {
    Name = "gw NAT"
  }
}

#---- 2 ----

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_nat_gateway" "gw" {
  # ... other arguments ...

  depends_on = ["aws_internet_gateway.gw"]
}