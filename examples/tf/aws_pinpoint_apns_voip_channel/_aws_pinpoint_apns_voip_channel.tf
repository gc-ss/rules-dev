

#---- 0 ----

resource "aws_pinpoint_apns_voip_channel" "apns_voip" {
  application_id = "${aws_pinpoint_app.app.application_id}"

  certificate = "${file("./certificate.pem")}"
  private_key = "${file("./private_key.key")}"
}

resource "aws_pinpoint_app" "app" {}