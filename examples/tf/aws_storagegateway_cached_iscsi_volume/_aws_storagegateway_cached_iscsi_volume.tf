

#---- 0 ----

resource "aws_storagegateway_cached_iscsi_volume" "example" {
  gateway_arn          = "${aws_storagegateway_cache.example.gateway_arn}"
  network_interface_id = "${aws_instance.example.private_ip}"
  target_name          = "example"
  volume_size_in_bytes = 5368709120 # 5 GB
}

#---- 1 ----

resource "aws_storagegateway_cached_iscsi_volume" "example" {
  gateway_arn          = "${aws_storagegateway_cache.example.gateway_arn}"
  network_interface_id = "${aws_instance.example.private_ip}"
  snapshot_id          = "${aws_ebs_snapshot.example.id}"
  target_name          = "example"
  volume_size_in_bytes = "${aws_ebs_snapshot.example.volume_size * 1024 * 1024 * 1024}"
}

#---- 2 ----

resource "aws_storagegateway_cached_iscsi_volume" "example" {
  gateway_arn          = "${aws_storagegateway_cache.example.gateway_arn}"
  network_interface_id = "${aws_instance.example.private_ip}"
  source_volume_arn    = "${aws_storagegateway_cached_iscsi_volume.existing.arn}"
  target_name          = "example"
  volume_size_in_bytes = "${aws_storagegateway_cached_iscsi_volume.existing.volume_size_in_bytes}"
}