resource "aws_datasync_task" "example" {
  destination_location_arn = "${aws_datasync_location_s3.destination.arn}"
  name                     = "example"
  source_location_arn      = "${aws_datasync_location_nfs.source.arn}"

  options {
    bytes_per_second = -1
  }
}