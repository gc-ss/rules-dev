resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "appsync.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  role       = "${aws_iam_role.example.name}"
}

resource "aws_appsync_graphql_api" "example" {
  # ... other configuration ...

  log_config {
    cloudwatch_logs_role_arn = "${aws_iam_role.example.arn}"
    field_log_level          = "ERROR"
  }
}