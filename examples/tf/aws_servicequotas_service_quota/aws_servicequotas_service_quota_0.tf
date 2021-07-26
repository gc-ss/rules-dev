resource "aws_servicequotas_service_quota" "example" {
  quota_code   = "L-F678F1CE"
  service_code = "vpc"
  value        = 75
}