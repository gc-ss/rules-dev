resource "aws_appmesh_virtual_router" "serviceb" {
  name      = "serviceB"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}