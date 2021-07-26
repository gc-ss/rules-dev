resource "aws_emr_cluster" "example" {
  # ... other configuration ...

  lifecycle {
    ignore_changes = ["kerberos_attributes"]
  }
}