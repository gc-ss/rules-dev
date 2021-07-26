resource "aws_pinpoint_gcm_channel" "gcm" {
  application_id = "${aws_pinpoint_app.app.application_id}"
  api_key        = "api_key"
}

resource "aws_pinpoint_app" "app" {}