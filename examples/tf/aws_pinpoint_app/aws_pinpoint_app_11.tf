resource "aws_pinpoint_apns_sandbox_channel" "apns_sandbox" {
  application_id = "${aws_pinpoint_app.app.application_id}"

  certificate = "${file("./certificate.pem")}"
  private_key = "${file("./private_key.key")}"
}

resource "aws_pinpoint_app" "app" {}