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