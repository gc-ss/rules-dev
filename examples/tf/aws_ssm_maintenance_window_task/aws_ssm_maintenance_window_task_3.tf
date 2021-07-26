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