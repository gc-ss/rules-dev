resource "aws_appautoscaling_policy" "example" {
  policy_type = "TargetTrackingScaling"

  # ... other configuration ...

  target_tracking_scaling_policy_configuration {
    target_value = 40

    # ... potentially other configuration ...

    customized_metric_specification {
      metric_name = "MyUtilizationMetric"
      namespace   = "MyNamespace"
      statistic   = "Average"
      unit        = "Percent"

      dimensions {
        name  = "MyOptionalMetricDimensionName"
        value = "MyOptionalMetricDimensionValue"
      }
    }
  }
}