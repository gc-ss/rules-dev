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