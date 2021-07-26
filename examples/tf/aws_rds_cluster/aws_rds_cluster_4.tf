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