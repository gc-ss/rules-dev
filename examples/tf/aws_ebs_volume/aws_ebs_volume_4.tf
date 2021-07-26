resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-2a"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = "${aws_ebs_volume.example.id}"

  tags = {
    Name = "HelloWorld_snap"
  }
}

resource "aws_ebs_snapshot_copy" "example_copy" {
  source_snapshot_id = "${aws_ebs_snapshot.example_snapshot.id}"
  source_region      = "us-west-2"

  tags = {
    Name = "HelloWorld_copy_snap"
  }
}