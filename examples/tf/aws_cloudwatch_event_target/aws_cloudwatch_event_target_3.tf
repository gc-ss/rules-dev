resource "aws_cloudwatch_event_rule" "stop_instances" {
  name                = "StopInstance"
  description         = "Stop instances nightly"
  schedule_expression = "cron(0 0 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop_instances" {
  target_id = "StopInstance"
  arn       = "arn:aws:ssm:${var.aws_region}::document/AWS-RunShellScript"
  input     = "{\"commands\":[\"halt\"]}"
  rule      = "${aws_cloudwatch_event_rule.stop_instances.name}"
  role_arn  = "${aws_iam_role.ssm_lifecycle.arn}"

  run_command_targets {
    key    = "tag:Terminate"
    values = ["midnight"]
  }
}