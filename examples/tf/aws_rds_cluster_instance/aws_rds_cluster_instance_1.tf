provider "aws" {
  alias  = "primary"
  region = "us-east-2"
}

provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
}

resource "aws_rds_global_cluster" "example" {
  provider = "aws.primary"

  global_cluster_identifier = "example"
}

resource "aws_rds_cluster" "primary" {
  provider = "aws.primary"

  # ... other configuration ...
  engine_mode               = "global"
  global_cluster_identifier = "${aws_rds_global_cluster.example.id}"
}

resource "aws_rds_cluster_instance" "primary" {
  provider = "aws.primary"

  # ... other configuration ...
  cluster_identifier = "${aws_rds_cluster.primary.id}"
}

resource "aws_rds_cluster" "secondary" {
  depends_on = ["aws_rds_cluster_instance.primary"]
  provider   = "aws.secondary"

  # ... other configuration ...
  engine_mode               = "global"
  global_cluster_identifier = "${aws_rds_global_cluster.example.id}"
}

resource "aws_rds_cluster_instance" "secondary" {
  provider = "aws.secondary"

  # ... other configuration ...
  cluster_identifier = "${aws_rds_cluster.secondary.id}"
}