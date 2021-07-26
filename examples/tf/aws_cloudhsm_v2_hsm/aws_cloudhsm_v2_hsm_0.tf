data "aws_cloudhsm_v2_cluster" "cluster" {
  cluster_id = "${var.cloudhsm_cluster_id}"
}

resource "aws_cloudhsm_v2_hsm" "cloudhsm_v2_hsm" {
  subnet_id  = "${data.aws_cloudhsm_v2_cluster.cluster.subnet_ids[0]}"
  cluster_id = "${data.aws_cloudhsm_v2_cluster.cluster.cluster_id}"
}