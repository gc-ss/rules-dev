

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