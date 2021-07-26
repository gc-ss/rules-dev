resource "aws_db_instance_role_association" "example" {
  db_instance_identifier = "${aws_db_instance.example.id}"
  feature_name           = "S3_INTEGRATION"
  role_arn               = "${aws_iam_role.example.id}"
}