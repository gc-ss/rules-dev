resource "aws_sns_topic" "topic" {
  name = "vpce-notification-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {
            "Service": "vpce.amazonaws.com"
        },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:vpce-notification-topic"
    }]
}
POLICY
}

resource "aws_vpc_endpoint_service" "foo" {
  acceptance_required        = false
  network_load_balancer_arns = ["${aws_lb.test.arn}"]
}

resource "aws_vpc_endpoint_connection_notification" "foo" {
  vpc_endpoint_service_id     = "${aws_vpc_endpoint_service.foo.id}"
  connection_notification_arn = "${aws_sns_topic.topic.arn}"
  connection_events           = ["Accept", "Reject"]
}