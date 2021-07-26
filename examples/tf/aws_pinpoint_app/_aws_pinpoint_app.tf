

#---- 0 ----

resource "aws_pinpoint_email_channel" "email" {
  application_id = "${aws_pinpoint_app.app.application_id}"
  from_address   = "user@example.com"
  identity       = "${aws_ses_domain_identity.identity.arn}"
  role_arn       = "${aws_iam_role.role.arn}"
}

resource "aws_pinpoint_app" "app" {}

resource "aws_ses_domain_identity" "identity" {
  domain = "example.com"
}

resource "aws_iam_role" "role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "pinpoint.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "role_policy" {
  name = "role_policy"
  role = "${aws_iam_role.role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "mobileanalytics:PutEvents",
      "mobileanalytics:PutItems"
    ],
    "Effect": "Allow",
    "Resource": [
      "*"
    ]
  }
}
EOF
}

#---- 1 ----

resource "aws_pinpoint_apns_voip_channel" "apns_voip" {
  application_id = "${aws_pinpoint_app.app.application_id}"

  certificate = "${file("./certificate.pem")}"
  private_key = "${file("./private_key.key")}"
}

resource "aws_pinpoint_app" "app" {}

#---- 2 ----

resource "aws_pinpoint_apns_voip_sandbox_channel" "apns_voip_sandbox" {
  application_id = "${aws_pinpoint_app.app.application_id}"

  certificate = "${file("./certificate.pem")}"
  private_key = "${file("./private_key.key")}"
}

resource "aws_pinpoint_app" "app" {}

#---- 3 ----

resource "aws_pinpoint_app" "app" {}

resource "aws_pinpoint_adm_channel" "channel" {
  application_id = "${aws_pinpoint_app.app.application_id}"
  client_id      = ""
  client_secret  = ""
  enabled        = true
}

#---- 4 ----

resource "aws_pinpoint_event_stream" "stream" {
  application_id         = "${aws_pinpoint_app.app.application_id}"
  destination_stream_arn = "${aws_kinesis_stream.test_stream.arn}"
  role_arn               = "${aws_iam_role.test_role.arn}"
}

resource "aws_pinpoint_app" "app" {}

resource "aws_kinesis_stream" "test_stream" {
  name        = "pinpoint-kinesis-test"
  shard_count = 1
}

resource "aws_iam_role" "test_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "pinpoint.us-east-1.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "test_role_policy" {
  name = "test_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "kinesis:PutRecords",
      "kinesis:DescribeStream"
    ],
    "Effect": "Allow",
    "Resource": [
      "arn:aws:kinesis:us-east-1:*:*/*"
    ]
  }
}
EOF
}

#---- 5 ----

resource "aws_pinpoint_apns_channel" "apns" {
  application_id = "${aws_pinpoint_app.app.application_id}"

  certificate = "${file("./certificate.pem")}"
  private_key = "${file("./private_key.key")}"
}

resource "aws_pinpoint_app" "app" {}

#---- 6 ----

resource "aws_pinpoint_gcm_channel" "gcm" {
  application_id = "${aws_pinpoint_app.app.application_id}"
  api_key        = "api_key"
}

resource "aws_pinpoint_app" "app" {}

#---- 7 ----

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

#---- 8 ----

resource "aws_pinpoint_sms_channel" "sms" {
  application_id = "${aws_pinpoint_app.app.application_id}"
}

resource "aws_pinpoint_app" "app" {}

#---- 9 ----

resource "aws_pinpoint_app" "app" {}

resource "aws_pinpoint_baidu_channel" "channel" {
  application_id = "${aws_pinpoint_app.app.application_id}"
  api_key        = ""
  secret_key     = ""
}

#---- 10 ----

resource "aws_pinpoint_app" "example" {
  name = "test-app"

  limits {
    maximum_duration = 600
  }

  quiet_time {
    start = "00:00"
    end   = "06:00"
  }
}

#---- 11 ----

resource "aws_pinpoint_apns_sandbox_channel" "apns_sandbox" {
  application_id = "${aws_pinpoint_app.app.application_id}"

  certificate = "${file("./certificate.pem")}"
  private_key = "${file("./private_key.key")}"
}

resource "aws_pinpoint_app" "app" {}