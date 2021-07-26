resource "aws_appmesh_route" "serviceb" {
  name                = "serviceB-route"
  mesh_name           = "${aws_appmesh_mesh.simple.id}"
  virtual_router_name = "${aws_appmesh_virtual_router.serviceb.name}"

  spec {
    http_route {
      match {
        prefix = "/"
      }

      action {
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.serviceb1.name}"
          weight       = 90
        }

        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.serviceb2.name}"
          weight       = 10
        }
      }
    }
  }
}