resource "aws_pinpoint_app" "example" {
  name = "test-app"

  limits {
    maximum_duration = 600
  }

  quiet_time {
    start = "00:00"
    end   = "06:00"
  }
}