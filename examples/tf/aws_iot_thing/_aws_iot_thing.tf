

#---- 0 ----

resource "aws_iot_thing" "example" {
  name = "example"

  attributes = {
    First = "examplevalue"
  }
}

#---- 1 ----

resource "aws_iot_thing" "example" {
  name = "example"
}

resource "aws_iot_certificate" "cert" {
  csr    = "${file("csr.pem")}"
  active = true
}

resource "aws_iot_thing_principal_attachment" "att" {
  principal = "${aws_iot_certificate.cert.arn}"
  thing     = "${aws_iot_thing.example.name}"
}