resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.us-west-2.s3"

  tags = {
    Environment = "test"
  }
}