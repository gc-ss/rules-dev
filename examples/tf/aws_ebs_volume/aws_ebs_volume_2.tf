resource "aws_snapshot_create_volume_permission" "example_perm" {
  snapshot_id = "${aws_ebs_snapshot.example_snapshot.id}"
  account_id  = "12345678"
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-2a"
  size              = 40
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = "${aws_ebs_volume.example.id}"
}