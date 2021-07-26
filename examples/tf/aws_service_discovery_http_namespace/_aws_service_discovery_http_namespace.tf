

#---- 0 ----

resource "aws_service_discovery_http_namespace" "example" {
  name        = "development"
  description = "example"
}

#---- 1 ----

resource "aws_service_discovery_http_namespace" "example" {
  name = "example-ns"
}

resource "aws_appmesh_virtual_node" "serviceb1" {
  name      = "serviceBv1"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    backend {
      virtual_service {
        virtual_service_name = "servicea.simpleapp.local"
      }
    }

    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        attributes = {
          stack = "blue"
        }

        service_name   = "serviceb1"
        namespace_name = "${aws_service_discovery_http_namespace.example.name}"
      }
    }
  }
}