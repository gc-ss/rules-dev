resource "aws_glue_trigger" "example" {
  name = "example"
  type = "CONDITIONAL"

  actions {
    job_name = "${aws_glue_job.example1.name}"
  }

  predicate {
    conditions {
      crawler_name = "${aws_glue_crawler.example2.name}"
      crawl_state  = "SUCCEEDED"
    }
  }
}