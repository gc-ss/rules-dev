

#---- 0 ----

resource "aws_sns_platform_application" "apns_application" {
  name                = "apns_application"
  platform            = "APNS"
  platform_credential = "<APNS PRIVATE KEY>"
  platform_principal  = "<APNS CERTIFICATE>"
}

#---- 1 ----

resource "aws_sns_platform_application" "gcm_application" {
  name                = "gcm_application"
  platform            = "GCM"
  platform_credential = "<GCM API KEY>"
}