resource "aws_storagegateway_gateway" "example" {
  gateway_ip_address = "1.2.3.4"
  gateway_name       = "example"
  gateway_timezone   = "GMT"
  gateway_type       = "VTL"
  media_changer_type = "AWS-Gateway-VTL"
  tape_drive_type    = "IBM-ULT3580-TD5"
}