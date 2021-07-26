resource "aws_docdb_cluster_snapshot" "example" {
  db_cluster_identifier          = "${aws_docdb_cluster.example.id}"
  db_cluster_snapshot_identifier = "resourcetestsnapshot1234"
}