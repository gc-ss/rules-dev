

#---- 0 ----

resource "aws_redshift_snapshot_copy_grant" "test" {
  snapshot_copy_grant_name = "my-grant"
}

resource "aws_redshift_cluster" "test" {
  # ... other configuration ...
  snapshot_copy {
    destination_region = "us-east-2"
    grant_name         = "${aws_redshift_snapshot_copy_grant.test.snapshot_copy_grant_name}"
  }
}