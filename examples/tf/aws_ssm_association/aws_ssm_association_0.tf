resource "aws_ssm_association" "example" {
  name = "${aws_ssm_document.example.name}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.example.id}"]
  }
}