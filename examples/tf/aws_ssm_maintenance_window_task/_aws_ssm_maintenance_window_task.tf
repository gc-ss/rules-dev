

#---- 0 ----

resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency  = 2
  max_errors       = 1
  priority         = 1
  service_role_arn = "${aws_iam_role.example.arn}"
  task_arn         = "AWS-RestartEC2Instance"
  task_type        = "AUTOMATION"
  window_id        = "${aws_ssm_maintenance_window.example.id}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.example.id}"]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"

      parameter {
        name   = "InstanceId"
        values = ["${aws_instance.example.id}"]
      }
    }
  }
}

#---- 1 ----

resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency  = 2
  max_errors       = 1
  priority         = 1
  service_role_arn = "${aws_iam_role.example.arn}"
  task_arn         = "${aws_lambda_function.example.arn}"
  task_type        = "LAMBDA"
  window_id        = "${aws_ssm_maintenance_window.example.id}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.example.id}"]
  }

  task_invocation_parameters {
    lambda_parameters {
      client_context = "${base64encode("{\"key1\":\"value1\"}")}"
      payload        = "{\"key1\":\"value1\"}"
    }
  }
}

#---- 2 ----

resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency  = 2
  max_errors       = 1
  priority         = 1
  service_role_arn = "${aws_iam_role.example.arn}"
  task_arn         = "AWS-RunShellScript"
  task_type        = "RUN_COMMAND"
  window_id        = "${aws_ssm_maintenance_window.example.id}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.example.id}"]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = "${aws_s3_bucket.example.bucket}"
      output_s3_key_prefix = "output"
      service_role_arn     = "${aws_iam_role.example.arn}"
      timeout_seconds      = 600

      notification_config {
        notification_arn    = "${aws_sns_topic.example.arn}"
        notification_events = ["All"]
        notification_type   = "Command"
      }

      parameter {
        name   = "commands"
        values = ["date"]
      }
    }
  }
}

#---- 3 ----

resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency  = 2
  max_errors       = 1
  priority         = 1
  service_role_arn = "${aws_iam_role.example.arn}"
  task_arn         = "${aws_sfn_activity.example.id}"
  task_type        = "STEP_FUNCTIONS"
  window_id        = "${aws_ssm_maintenance_window.example.id}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.example.id}"]
  }

  task_invocation_parameters {
    step_functions_parameters {
      input = "{\"key1\":\"value1\"}"
      name  = "example"
    }
  }
}