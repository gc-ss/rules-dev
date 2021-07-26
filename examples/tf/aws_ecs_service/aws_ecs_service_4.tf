resource "aws_ecs_service" "example" {
  name    = "example"
  cluster = "${aws_ecs_cluster.example.id}"

  deployment_controller {
    type = "EXTERNAL"
  }
}