

#---- 0 ----

resource "aws_iam_role" "role" {
  name = "dynamodb-access-role"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"Service": "credentials.iot.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iot_role_alias" "alias" {
  alias    = "Thermostat-dynamodb-access-role-alias"
  role_arn = "${aws_iam_role.role.arn}"
}