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