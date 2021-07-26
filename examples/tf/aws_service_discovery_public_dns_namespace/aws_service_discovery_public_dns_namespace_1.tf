resource "aws_service_discovery_public_dns_namespace" "example" {
  name        = "hoge.example.com"
  description = "example"
}