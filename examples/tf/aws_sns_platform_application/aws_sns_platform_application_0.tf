resource "aws_sns_platform_application" "apns_application" {
  name                = "apns_application"
  platform            = "APNS"
  platform_credential = "<APNS PRIVATE KEY>"
  platform_principal  = "<APNS CERTIFICATE>"
}