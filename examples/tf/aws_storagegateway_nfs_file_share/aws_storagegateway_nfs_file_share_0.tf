resource "aws_storagegateway_nfs_file_share" "example" {
  client_list  = ["0.0.0.0/0"]
  gateway_arn  = "${aws_storagegateway_gateway.example.arn}"
  location_arn = "${aws_s3_bucket.example.arn}"
  role_arn     = "${aws_iam_role.example.arn}"
}