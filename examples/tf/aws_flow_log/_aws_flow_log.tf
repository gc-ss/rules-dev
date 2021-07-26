

#---- 0 ----

resource "aws_flow_log" "example" {
  iam_role_arn    = "${aws_iam_role.example.arn}"
  log_destination = "${aws_cloudwatch_log_group.example.arn}"
  traffic_type    = "ALL"
  vpc_id          = "${aws_vpc.example.id}"
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example"
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = "${aws_iam_role.example.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#---- 1 ----

resource "aws_flow_log" "example" {
  log_destination      = "${aws_s3_bucket.example.arn}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = "${aws_vpc.example.id}"
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}