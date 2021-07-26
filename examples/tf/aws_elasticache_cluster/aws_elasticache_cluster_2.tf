resource "aws_elasticache_cluster" "replica" {
  cluster_id           = "cluster-example"
  replication_group_id = "${aws_elasticache_replication_group.example.id}"
}