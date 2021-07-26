resource "aws_msk_configuration" "example" {
  kafka_versions = ["2.1.0"]
  name           = "example"

  server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
PROPERTIES
}