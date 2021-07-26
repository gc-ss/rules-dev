resource "aws_dax_subnet_group" "example" {
  name       = "example"
  subnet_ids = ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"]
}