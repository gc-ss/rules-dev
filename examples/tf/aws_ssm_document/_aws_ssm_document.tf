

#---- 0 ----

resource "aws_ssm_document" "foo" {
  name          = "test_document"
  document_type = "Command"

  content = <<DOC
  {
    "schemaVersion": "1.2",
    "description": "Check ip configuration of a Linux instance.",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["ifconfig"]
          }
        ]
      }
    }
  }
DOC
}

#---- 1 ----

resource "aws_ssm_document" "test" {
  name          = "test_document"
  document_type = "Package"

  attachments_source {
    key    = "SourceUrl"
    values = ["s3://${aws_s3_bucket.object_bucket.bucket}/test.zip"]
  }

  # There is no AWS SSM API for reading attachments_source info directly
  lifecycle {
    ignore_changes = ["attachments_source"]
  }
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