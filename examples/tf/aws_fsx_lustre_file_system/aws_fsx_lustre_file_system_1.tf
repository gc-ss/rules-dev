resource "aws_fsx_lustre_file_system" "example" {
  # ... other configuration ...
  security_group_ids = ["${aws_security_group.example.id}"]

  # There is no FSx API for reading security_group_ids
  lifecycle {
    ignore_changes = ["security_group_ids"]
  }
}