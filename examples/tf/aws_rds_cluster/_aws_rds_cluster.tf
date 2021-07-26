

#---- 0 ----

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

#---- 1 ----

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

#---- 2 ----

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

#---- 3 ----

resource "aws_rds_cluster" "example" {
  cluster_identifier   = "example"
  db_subnet_group_name = "${aws_db_subnet_group.example.name}"
  engine_mode          = "multimaster"
  master_password      = "barbarbarbar"
  master_username      = "foo"
  skip_final_snapshot  = true
}

#---- 4 ----

resource "aws_rds_cluster" "db" {
  engine = "aurora"

  s3_import {
    source_engine         = "mysql"
    source_engine_version = "5.6"
    bucket_name           = "mybucket"
    bucket_prefix         = "backups"
    ingestion_role        = "arn:aws:iam::1234567890:role/role-xtrabackup-rds-restore"
  }
}

#---- 5 ----

resource "aws_rds_cluster" "example" {
  # ... other configuration ...

  engine_mode = "serverless"

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 256
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

#---- 6 ----

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster_instance" "test1" {
  apply_immediately  = true
  cluster_identifier = "${aws_rds_cluster.default.id}"
  identifier         = "test1"
  instance_class     = "db.t2.small"
  engine             = "${aws_rds_cluster.default.engine}"
  engine_version     = "${aws_rds_cluster.default.engine_version}"
}

resource "aws_rds_cluster_instance" "test2" {
  apply_immediately  = true
  cluster_identifier = "${aws_rds_cluster.default.id}"
  identifier         = "test2"
  instance_class     = "db.t2.small"
  engine             = "${aws_rds_cluster.default.engine}"
  engine_version     = "${aws_rds_cluster.default.engine_version}"
}

resource "aws_rds_cluster_instance" "test3" {
  apply_immediately  = true
  cluster_identifier = "${aws_rds_cluster.default.id}"
  identifier         = "test3"
  instance_class     = "db.t2.small"
  engine             = "${aws_rds_cluster.default.engine}"
  engine_version     = "${aws_rds_cluster.default.engine_version}"
}

resource "aws_rds_cluster_endpoint" "eligible" {
  cluster_identifier          = "${aws_rds_cluster.default.id}"
  cluster_endpoint_identifier = "reader"
  custom_endpoint_type        = "READER"

  excluded_members = [
    "${aws_rds_cluster_instance.test1.id}",
    "${aws_rds_cluster_instance.test2.id}",
  ]
}

resource "aws_rds_cluster_endpoint" "static" {
  cluster_identifier          = "${aws_rds_cluster.default.id}"
  cluster_endpoint_identifier = "static"
  custom_endpoint_type        = "READER"

  static_members = [
    "${aws_rds_cluster_instance.test1.id}",
    "${aws_rds_cluster_instance.test3.id}",
  ]
}

#---- 7 ----

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

#---- 8 ----

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "db.r4.large"
  engine             = "${aws_rds_cluster.default.engine}"
  engine_version     = "${aws_rds_cluster.default.engine_version}"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "aurora-cluster-demo"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name      = "mydb"
  master_username    = "foo"
  master_password    = "barbut8chars"
}