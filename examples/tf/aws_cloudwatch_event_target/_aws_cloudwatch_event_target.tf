

#---- 0 ----

resource "aws_cloudwatch_event_rule" "console" {
  name        = "capture-aws-sign-in"
  description = "Capture each AWS Console Sign In"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = "${aws_cloudwatch_event_rule.console.name}"
  target_id = "SendToSNS"
  arn       = "${aws_sns_topic.aws_logins.arn}"
}

resource "aws_sns_topic" "aws_logins" {
  name = "aws-console-logins"
}

resource "aws_sns_topic_policy" "default" {
  arn    = "${aws_sns_topic.aws_logins.arn}"
  policy = "${data.aws_iam_policy_document.sns_topic_policy.json}"
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = ["${aws_sns_topic.aws_logins.arn}"]
  }
}

#---- 1 ----

resource "aws_cloudwatch_event_target" "yada" {
  target_id = "Yada"
  rule      = "${aws_cloudwatch_event_rule.console.name}"
  arn       = "${aws_kinesis_stream.test_stream.arn}"

  run_command_targets {
    key    = "tag:Name"
    values = ["FooBar"]
  }

  run_command_targets {
    key    = "InstanceIds"
    values = ["i-162058cd308bffec2"]
  }
}

resource "aws_cloudwatch_event_rule" "console" {
  name        = "capture-ec2-scaling-events"
  description = "Capture all EC2 scaling events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful",
    "EC2 Instance Terminate Successful",
    "EC2 Instance Launch Unsuccessful",
    "EC2 Instance Terminate Unsuccessful"
  ]
}
PATTERN
}

resource "aws_kinesis_stream" "test_stream" {
  name        = "terraform-kinesis-test"
  shard_count = 1
}

#---- 2 ----

data "aws_iam_policy_document" "ssm_lifecycle_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ssm_lifecycle" {
  statement {
    effect    = "Allow"
    actions   = ["ssm:SendCommand"]
    resources = ["arn:aws:ec2:eu-west-1:1234567890:instance/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Terminate"
      values   = ["*"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["ssm:SendCommand"]
    resources = ["${aws_ssm_document.stop_instance.arn}"]
  }
}

resource "aws_iam_role" "ssm_lifecycle" {
  name               = "SSMLifecycle"
  assume_role_policy = "${data.aws_iam_policy_document.ssm_lifecycle_trust.json}"
}

resource "aws_iam_policy" "ssm_lifecycle" {
  name   = "SSMLifecycle"
  policy = "${data.aws_iam_policy_document.ssm_lifecycle.json}"
}

resource "aws_ssm_document" "stop_instance" {
  name          = "stop_instance"
  document_type = "Command"

  content = <<DOC
  {
    "schemaVersion": "1.2",
    "description": "Stop an instance",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["halt"]
          }
        ]
      }
    }
  }
DOC
}

resource "aws_cloudwatch_event_rule" "stop_instances" {
  name                = "StopInstance"
  description         = "Stop instances nightly"
  schedule_expression = "cron(0 0 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop_instances" {
  target_id = "StopInstance"
  arn       = "${aws_ssm_document.stop_instance.arn}"
  rule      = "${aws_cloudwatch_event_rule.stop_instances.name}"
  role_arn  = "${aws_iam_role.ssm_lifecycle.arn}"

  run_command_targets {
    key    = "tag:Terminate"
    values = ["midnight"]
  }
}

#---- 3 ----

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

#---- 4 ----

resource "aws_iam_role" "ecs_events" {
  name = "ecs_events"

  assume_role_policy = <<DOC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
DOC
}

resource "aws_iam_role_policy" "ecs_events_run_task_with_any_role" {
  name = "ecs_events_run_task_with_any_role"
  role = "${aws_iam_role.ecs_events.id}"

  policy = <<DOC
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ecs:RunTask",
            "Resource": "${replace(aws_ecs_task_definition.task_name.arn, "/:\\d+$/", ":*")}"
        }
    ]
}
DOC
}

resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  target_id = "run-scheduled-task-every-hour"
  arn       = "${aws_ecs_cluster.cluster_name.arn}"
  rule      = "${aws_cloudwatch_event_rule.every_hour.name}"
  role_arn  = "${aws_iam_role.ecs_events.arn}"

  ecs_target {
    task_count          = 1
    task_definition_arn = "${aws_ecs_task_definition.task_name.arn}"
  }

  input = <<DOC
{
  "containerOverrides": [
    {
      "name": "name-of-container-to-override",
      "command": ["bin/console", "scheduled-task"]
    }
  ]
}
DOC
}