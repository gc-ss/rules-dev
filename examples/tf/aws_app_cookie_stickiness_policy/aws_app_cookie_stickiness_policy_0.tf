resource "aws_elb" "lb" {
  name               = "test-lb"
  availability_zones = ["us-east-1a"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_app_cookie_stickiness_policy" "foo" {
  name          = "foo_policy"
  load_balancer = "${aws_elb.lb.name}"
  lb_port       = 80
  cookie_name   = "MyAppCookie"
}