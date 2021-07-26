

#---- 0 ----

resource "aws_ecs_service" "ecs_service" {
  name            = "serviceName"
  cluster         = "clusterName"
  task_definition = "taskDefinitionFamily:1"
  desired_count   = 2

  lifecycle {
    ignore_changes = ["desired_count"]
  }
}

#---- 1 ----

resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = "${aws_ecs_cluster.foo.id}"
  task_definition = "${aws_ecs_task_definition.mongo.arn}"
  desired_count   = 3
  iam_role        = "${aws_iam_role.foo.arn}"
  depends_on      = ["aws_iam_role_policy.foo"]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.foo.arn}"
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

#---- 2 ----

resource "aws_ecs_service" "example" {
  # ... other configurations ...

  # Example: Create service with 2 instances to start
  desired_count = 2

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = ["desired_count"]
  }
}

#---- 3 ----

resource "aws_ecs_service" "bar" {
  name                = "bar"
  cluster             = "${aws_ecs_cluster.foo.id}"
  task_definition     = "${aws_ecs_task_definition.bar.arn}"
  scheduling_strategy = "DAEMON"
}

#---- 4 ----

resource "aws_ecs_service" "example" {
  name    = "example"
  cluster = "${aws_ecs_cluster.example.id}"

  deployment_controller {
    type = "EXTERNAL"
  }
}