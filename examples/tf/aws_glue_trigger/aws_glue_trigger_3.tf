resource "aws_glue_trigger" "example" {
  name     = "example"
  schedule = "cron(15 12 * * ? *)"
  type     = "SCHEDULED"

  actions {
    job_name = "${aws_glue_job.example.name}"
  }
}