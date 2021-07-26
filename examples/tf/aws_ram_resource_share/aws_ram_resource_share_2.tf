resource "aws_ram_resource_share" "example" {
  name                      = "example"
  allow_external_principals = true

  tags = {
    Environment = "Production"
  }
}