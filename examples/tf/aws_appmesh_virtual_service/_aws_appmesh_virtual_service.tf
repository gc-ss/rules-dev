

#---- 0 ----

resource "aws_appmesh_virtual_service" "servicea" {
  name      = "servicea.simpleapp.local"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    provider {
      virtual_node {
        virtual_node_name = "${aws_appmesh_virtual_node.serviceb1.name}"
      }
    }
  }
}

#---- 1 ----

resource "aws_appmesh_virtual_service" "servicea" {
  name      = "servicea.simpleapp.local"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    provider {
      virtual_router {
        virtual_router_name = "${aws_appmesh_virtual_router.serviceb.name}"
      }
    }
  }
}