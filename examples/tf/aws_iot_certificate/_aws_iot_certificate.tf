

#---- 0 ----

resource "aws_iot_policy" "pubsub" {
  name = "PubSubToAnyTopic"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iot:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iot_certificate" "cert" {
  csr    = "${file("csr.pem")}"
  active = true
}

resource "aws_iot_policy_attachment" "att" {
  policy = "${aws_iot_policy.pubsub.name}"
  target = "${aws_iot_certificate.cert.arn}"
}

#---- 1 ----

resource "aws_iot_certificate" "cert" {
  csr    = "${file("/my/csr.pem")}"
  active = true
}

#---- 2 ----

resource "aws_iot_certificate" "cert" {
  active = true
}

#---- 3 ----

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