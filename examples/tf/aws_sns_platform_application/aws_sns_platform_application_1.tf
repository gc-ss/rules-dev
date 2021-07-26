resource "aws_sns_platform_application" "gcm_application" {
  name                = "gcm_application"
  platform            = "GCM"
  platform_credential = "<GCM API KEY>"
}