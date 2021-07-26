resource "aws_glue_trigger" "example" {
  name = "example"
  type = "CONDITIONAL"

  actions {
    crawler_name = "${aws_glue_crawler.example1.name}"
  }

  predicate {
    conditions {
      job_name = "${aws_glue_job.example2.name}"
      state    = "SUCCEEDED"
    }
  }
}