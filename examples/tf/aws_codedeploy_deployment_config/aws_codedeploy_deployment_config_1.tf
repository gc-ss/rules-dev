resource "aws_codedeploy_deployment_config" "foo" {
  deployment_config_name = "test-deployment-config"
  compute_platform       = "Lambda"

  traffic_routing_config {
    type = "TimeBasedLinear"

    time_based_linear {
      interval   = 10
      percentage = 10
    }
  }
}

resource "aws_codedeploy_deployment_group" "foo" {
  app_name               = "${aws_codedeploy_app.foo_app.name}"
  deployment_group_name  = "bar"
  service_role_arn       = "${aws_iam_role.foo_role.arn}"
  deployment_config_name = "${aws_codedeploy_deployment_config.foo.id}"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_STOP_ON_ALARM"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}