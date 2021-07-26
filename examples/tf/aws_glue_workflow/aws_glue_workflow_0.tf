resource "aws_glue_workflow" "example" {
  name = "example"
}

resource "aws_glue_trigger" "example-start" {
  name          = "trigger-start"
  type          = "ON_DEMAND"
  workflow_name = "${aws_glue_workflow.example.name}"

  actions {
    job_name = "example-job"
  }
}

resource "aws_glue_trigger" "example-inner" {
  name          = "trigger-inner"
  type          = "CONDITIONAL"
  workflow_name = "${aws_glue_workflow.example.name}"

  predicate {
    conditions {
      job_name = "example-job"
      state    = "SUCCEEDED"
    }
  }

  actions {
    job_name = "another-example-job"
  }
}