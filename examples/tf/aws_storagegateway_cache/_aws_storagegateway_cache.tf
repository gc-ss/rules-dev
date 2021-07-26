

#---- 0 ----

resource "aws_storagegateway_cache" "example" {
  disk_id     = "${data.aws_storagegateway_local_disk.example.id}"
  gateway_arn = "${aws_storagegateway_gateway.example.arn}"
}