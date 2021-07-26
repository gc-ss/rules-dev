

#---- 0 ----

resource "aws_service_discovery_public_dns_namespace" "example" {
  name        = "example.terraform.com"
  description = "example"
}

resource "aws_service_discovery_service" "example" {
  name = "example"

  dns_config {
    namespace_id = "${aws_service_discovery_public_dns_namespace.example.id}"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_config {
    failure_threshold = 10
    resource_path     = "path"
    type              = "HTTP"
  }
}

#---- 1 ----

resource "aws_service_discovery_public_dns_namespace" "example" {
  name        = "hoge.example.com"
  description = "example"
}