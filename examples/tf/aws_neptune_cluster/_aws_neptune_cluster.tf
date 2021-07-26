

#---- 0 ----

resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = "neptune-cluster-demo"
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = "true"
  apply_immediately                   = "true"
}

resource "aws_neptune_cluster_instance" "example" {
  count              = 1
  cluster_identifier = "${aws_neptune_cluster.default.id}"
  engine             = "neptune"
  instance_class     = "db.r4.large"
  apply_immediately  = "true"
}

resource "aws_sns_topic" "default" {
  name = "neptune-events"
}

resource "aws_neptune_event_subscription" "default" {
  name          = "neptune-event-sub"
  sns_topic_arn = "${aws_sns_topic.default.arn}"

  source_type = "db-instance"
  source_ids  = ["${aws_neptune_cluster_instance.example.id}"]

  event_categories = [
    "maintenance",
    "availability",
    "creation",
    "backup",
    "restoration",
    "recovery",
    "deletion",
    "failover",
    "failure",
    "notification",
    "configuration change",
    "read replica",
  ]

  tags = {
    "env" = "test"
  }
}

#---- 1 ----

resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = "neptune-cluster-demo"
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true
  apply_immediately                   = true
}

resource "aws_neptune_cluster_instance" "example" {
  count              = 2
  cluster_identifier = "${aws_neptune_cluster.default.id}"
  engine             = "neptune"
  instance_class     = "db.r4.large"
  apply_immediately  = true
}

#---- 2 ----

resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = "neptune-cluster-demo"
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true
  apply_immediately                   = true
}