

#---- 0 ----

resource "aws_datasync_location_s3" "example" {
  s3_bucket_arn = "${aws_s3_bucket.example.arn}"
  subdirectory  = "/example/prefix"

  s3_config {
    bucket_access_role_arn = "${aws_iam_role.example.arn}"
  }
}