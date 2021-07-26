

#---- 0 ----

resource "aws_glue_job" "example" {
  name     = "example"
  role_arn = "${aws_iam_role.example.arn}"

  command {
    script_location = "s3://${aws_s3_bucket.example.bucket}/example.py"
  }
}

#---- 1 ----

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

#---- 2 ----

resource "aws_cloudwatch_log_group" "example" {
  name              = "example"
  retention_in_days = 14
}

resource "aws_glue_job" "example" {
  # ... other configuration ...

  default_arguments = {
    # ... potentially other arguments ...
    "--continuous-log-logGroup"          = "${aws_cloudwatch_log_group.example.name}"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
  }
}