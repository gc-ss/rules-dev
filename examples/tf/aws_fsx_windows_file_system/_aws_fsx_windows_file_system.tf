

#---- 0 ----

resource "aws_fsx_windows_file_system" "example" {
  active_directory_id = "${aws_directory_service_directory.example.id}"
  kms_key_id          = "${aws_kms_key.example.arn}"
  storage_capacity    = 300
  subnet_ids          = ["${aws_subnet.example.id}"]
  throughput_capacity = 1024
}

#---- 1 ----

resource "aws_fsx_windows_file_system" "example" {
  kms_key_id          = "${aws_kms_key.example.arn}"
  storage_capacity    = 300
  subnet_ids          = ["${aws_subnet.example.id}"]
  throughput_capacity = 1024

  self_managed_active_directory {
    dns_ips     = ["10.0.0.111", "10.0.0.222"]
    domain_name = "corp.example.com"
    password    = "avoid-plaintext-passwords"
    username    = "Admin"
  }
}

#---- 2 ----

resource "aws_fsx_windows_file_system" "example" {
  # ... other configuration ...
  security_group_ids = ["${aws_security_group.example.id}"]

  # There is no FSx API for reading security_group_ids
  lifecycle {
    ignore_changes = ["security_group_ids"]
  }
}