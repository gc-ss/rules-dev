resource "aws_cloudwatch_metric_alarm" "xx_anomaly_detection" {
  alarm_name                = "terraform-test-foobar"
  comparison_operator       = "GreaterThanUpperThreshold"
  evaluation_periods        = "2"
  threshold_metric_id       = "e1"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "CPUUtilization (Expected)"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/EC2"
      period      = "120"
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        InstanceId = "i-abc123"
      }
    }
  }
}