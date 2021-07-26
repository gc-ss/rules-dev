resource "aws_gamelift_build" "test" {
  name             = "example-build"
  operating_system = "WINDOWS_2012"

  storage_location {
    bucket   = "${aws_s3_bucket.test.bucket}"
    key      = "${aws_s3_bucket_object.test.key}"
    role_arn = "${aws_iam_role.test.arn}"
  }

  depends_on = ["aws_iam_role_policy.test"]
}