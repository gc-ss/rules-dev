resource "aws_vpc_peering_connection_accepter" "example" {
  # ... other configuration ...

  # There is no AWS EC2 API for reading auto_accept
  lifecycle {
    ignore_changes = ["auto_accept"]
  }
}