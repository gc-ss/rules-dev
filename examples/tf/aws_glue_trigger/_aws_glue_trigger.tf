

#---- 0 ----

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

#---- 1 ----

resource "aws_glue_trigger" "example" {
  name = "example"
  type = "CONDITIONAL"

  actions {
    job_name = "${aws_glue_job.example1.name}"
  }

  predicate {
    conditions {
      job_name = "${aws_glue_job.example2.name}"
      state    = "SUCCEEDED"
    }
  }
}

#---- 2 ----

resource "aws_glue_trigger" "example" {
  name = "example"
  type = "ON_DEMAND"

  actions {
    job_name = "${aws_glue_job.example.name}"
  }
}

#---- 3 ----

resource "aws_glue_trigger" "example" {
  name     = "example"
  schedule = "cron(15 12 * * ? *)"
  type     = "SCHEDULED"

  actions {
    job_name = "${aws_glue_job.example.name}"
  }
}

#---- 4 ----

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

#---- 5 ----

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