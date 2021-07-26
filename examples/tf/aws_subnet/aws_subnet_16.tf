resource "aws_directory_service_directory" "connector" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  size     = "Small"
  type     = "ADConnector"

  connect_settings {
    customer_dns_ips  = ["A.B.C.D"]
    customer_username = "Admin"
    subnet_ids        = ["${aws_subnet.foo.id}", "${aws_subnet.bar.id}"]
    vpc_id            = "${aws_vpc.main.id}"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "foo" {
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "bar" {
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "us-west-2b"
  cidr_block        = "10.0.2.0/24"
}