

#---- 0 ----

resource "aws_redshift_cluster" "default" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "mydb"
  master_username    = "foo"
  master_password    = "Mustbe8characters"
  node_type          = "dc1.large"
  cluster_type       = "single-node"
}

resource "aws_redshift_snapshot_schedule" "default" {
  identifier = "tf-redshift-snapshot-schedule"
  definitions = [
    "rate(12 hours)",
  ]
}

resource "aws_redshift_snapshot_schedule_association" "default" {
  cluster_identifier  = "${aws_redshift_cluster.default.id}"
  schedule_identifier = "${aws_redshift_snapshot_schedule.default.id}"
}