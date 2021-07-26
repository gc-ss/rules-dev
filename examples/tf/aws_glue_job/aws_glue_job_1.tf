resource "aws_glue_job" "example" {
  name     = "example"
  role_arn = "${aws_iam_role.example.arn}"

  command {
    script_location = "s3://${aws_s3_bucket.example.bucket}/example.scala"
  }

  default_arguments = {
    "--job-language" = "scala"
  }
}