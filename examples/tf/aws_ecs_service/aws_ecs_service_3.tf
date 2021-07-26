resource "aws_ecs_service" "bar" {
  name                = "bar"
  cluster             = "${aws_ecs_cluster.foo.id}"
  task_definition     = "${aws_ecs_task_definition.bar.arn}"
  scheduling_strategy = "DAEMON"
}