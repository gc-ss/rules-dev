resource "aws_pinpoint_app" "app" {}

resource "aws_pinpoint_baidu_channel" "channel" {
  application_id = "${aws_pinpoint_app.app.application_id}"
  api_key        = ""
  secret_key     = ""
}