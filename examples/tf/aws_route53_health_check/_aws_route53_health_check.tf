

#---- 0 ----

resource "aws_route53_health_check" "example" {
  fqdn              = "example.com"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "tf-test-health-check"
  }
}

#---- 1 ----

resource "aws_route53_health_check" "example" {
  failure_threshold = "5"
  fqdn              = "example.com"
  port              = 443
  request_interval  = "30"
  resource_path     = "/"
  search_string     = "example"
  type              = "HTTPS_STR_MATCH"
}

#---- 2 ----

resource "aws_route53_health_check" "parent" {
  type                   = "CALCULATED"
  child_health_threshold = 1
  child_healthchecks     = ["${aws_route53_health_check.child.id}"]

  tags = {
    Name = "tf-test-calculated-health-check"
  }
}

#---- 3 ----

resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name          = "terraform-test-foobar5"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
}

resource "aws_route53_health_check" "foo" {
  type                            = "CLOUDWATCH_METRIC"
  cloudwatch_alarm_name           = "${aws_cloudwatch_metric_alarm.foobar.alarm_name}"
  cloudwatch_alarm_region         = "us-west-2"
  insufficient_data_health_status = "Healthy"
}