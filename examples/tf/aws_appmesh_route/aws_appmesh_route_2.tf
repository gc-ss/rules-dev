resource "aws_appmesh_route" "serviceb" {
  name                = "serviceB-route"
  mesh_name           = "${aws_appmesh_mesh.simple.id}"
  virtual_router_name = "${aws_appmesh_virtual_router.serviceb.name}"

  spec {
    tcp_route {
      action {
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.serviceb1.name}"
          weight       = 100
        }
      }
    }
  }
}