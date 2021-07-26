resource "aws_vpc" "foo" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "foo" {
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-west-2a"
  vpc_id            = "${aws_vpc.foo.id}"

  tags = {
    Name = "tf-dbsubnet-test-1"
  }
}

resource "aws_subnet" "bar" {
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-west-2b"
  vpc_id            = "${aws_vpc.foo.id}"

  tags = {
    Name = "tf-dbsubnet-test-2"
  }
}

resource "aws_redshift_subnet_group" "foo" {
  name       = "foo"
  subnet_ids = ["${aws_subnet.foo.id}", "${aws_subnet.bar.id}"]

  tags = {
    environment = "Production"
  }
}