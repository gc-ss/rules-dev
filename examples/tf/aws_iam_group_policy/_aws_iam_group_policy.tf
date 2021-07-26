

#---- 0 ----

resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = "${aws_iam_group.my_developers.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group" "my_developers" {
  name = "developers"
  path = "/users/"
}