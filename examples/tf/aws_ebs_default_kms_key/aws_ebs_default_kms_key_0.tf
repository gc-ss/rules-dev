resource "aws_ebs_default_kms_key" "example" {
  key_arn = "${aws_kms_key.example.arn}"
}