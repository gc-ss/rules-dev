

#---- 0 ----

resource "aws_ssm_maintenance_window" "production" {
  name     = "maintenance-window-application"
  schedule = "cron(0 16 ? * TUE *)"
  duration = 3
  cutoff   = 1
}

#---- 1 ----

resource "aws_ssm_maintenance_window" "window" {
  name     = "maintenance-window-webapp"
  schedule = "cron(0 16 ? * TUE *)"
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id     = "${aws_ssm_maintenance_window.window.id}"
  name          = "maintenance-window-target"
  description   = "This is a maintenance window target"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Name"
    values = ["acceptance_test"]
  }
}

#---- 2 ----

resource "aws_ssm_maintenance_window" "window" {
  name     = "maintenance-window-webapp"
  schedule = "cron(0 16 ? * TUE *)"
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id     = "${aws_ssm_maintenance_window.window.id}"
  name          = "maintenance-window-target"
  description   = "This is a maintenance window target"
  resource_type = "RESOURCE_GROUP"

  targets {
    key    = "resource-groups:ResourceTypeFilters"
    values = ["AWS::EC2::INSTANCE", "AWS::EC2::VPC"]
  }
}