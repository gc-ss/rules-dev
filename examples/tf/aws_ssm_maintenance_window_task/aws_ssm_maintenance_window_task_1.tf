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