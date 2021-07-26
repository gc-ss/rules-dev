resource "aws_worklink_fleet" "example" {
  name = "terraform-example"

  network {
    vpc_id             = "${aws_vpc.test.id}"
    subnet_ids         = ["${aws_subnet.test.*.id}"]
    security_group_ids = ["${aws_security_group.test.id}"]
  }
}