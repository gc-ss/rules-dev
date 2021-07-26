data "aws_caller_identity" "current" {}

resource "aws_cognito_user_pool" "test" {
  name = "pool"
}

resource "aws_pinpoint_app" "test" {
  name = "pinpoint"
}

resource "aws_iam_role" "test" {
  name = "role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cognito-idp.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "test" {
  name = "role_policy"
  role = "${aws_iam_role.test.id}"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "mobiletargeting:UpdateEndpoint",
          "mobiletargeting:PutItems"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:mobiletargeting:*:${data.aws_caller_identity.current.account_id}:apps/${aws_pinpoint_app.test.application_id}*"
      }
    ]
  }
  EOF
}

resource "aws_cognito_user_pool_client" "test" {
  name         = "pool_client"
  user_pool_id = "${aws_cognito_user_pool.test.id}"

  analytics_configuration {
    application_id   = "${aws_pinpoint_app.test.application_id}"
    external_id      = "some_id"
    role_arn         = "${aws_iam_role.test.arn}"
    user_data_shared = true
  }
}