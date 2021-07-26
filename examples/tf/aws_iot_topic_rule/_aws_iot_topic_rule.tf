

#---- 0 ----

resource "aws_iot_topic_rule" "rule" {
  name        = "MyRule"
  description = "Example rule"
  enabled     = true
  sql         = "SELECT * FROM 'topic/test'"
  sql_version = "2016-03-23"

  sns {
    message_format = "RAW"
    role_arn       = "${aws_iam_role.role.arn}"
    target_arn     = "${aws_sns_topic.mytopic.arn}"
  }

  error_action {
    sns {
      message_format = "RAW"
      role_arn       = "${aws_iam_role.role.arn}"
      target_arn     = "${aws_sns_topic.myerrortopic.arn}"
    }
  }
}

resource "aws_sns_topic" "mytopic" {
  name = "mytopic"
}

resource "aws_sns_topic" "myerrortopic" {
  name = "myerrortopic"
}

resource "aws_iam_role" "role" {
  name = "myrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "iot.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_policy_for_lambda" {
  name = "mypolicy"
  role = "${aws_iam_role.role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "sns:Publish"
        ],
        "Resource": "${aws_sns_topic.mytopic.arn}"
    }
  ]
}
EOF
}