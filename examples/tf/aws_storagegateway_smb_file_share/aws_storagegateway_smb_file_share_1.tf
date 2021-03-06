resource "aws_storagegateway_smb_file_share" "example" {
  authentication = "GuestAccess"
  gateway_arn    = "${aws_storagegateway_gateway.example.arn}"
  location_arn   = "${aws_s3_bucket.example.arn}"
  role_arn       = "${aws_iam_role.example.arn}"
}