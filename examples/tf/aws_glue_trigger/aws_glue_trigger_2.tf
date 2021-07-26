resource "aws_glue_trigger" "example" {
  name = "example"
  type = "ON_DEMAND"

  actions {
    job_name = "${aws_glue_job.example.name}"
  }
}