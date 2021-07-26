

#---- 0 ----

resource "aws_dax_cluster" "bar" {
  cluster_name       = "cluster-example"
  iam_role_arn       = "${data.aws_iam_role.example.arn}"
  node_type          = "dax.r4.large"
  replication_factor = 1
}