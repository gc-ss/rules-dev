resource "aws_s3_bucket" "hoge" {
  bucket = "tf-test"
}

resource "aws_kms_key" "test" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key"
}

resource "aws_athena_workgroup" "test" {
  name = "example"

  configuration {
    result_configuration {
      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = "${aws_kms_key.test.arn}"
      }
    }
  }
}

resource "aws_athena_database" "hoge" {
  name   = "users"
  bucket = "${aws_s3_bucket.hoge.id}"
}

resource "aws_athena_named_query" "foo" {
  name      = "bar"
  workgroup = "${aws_athena_workgroup.test.id}"
  database  = "${aws_athena_database.hoge.name}"
  query     = "SELECT * FROM ${aws_athena_database.hoge.name} limit 10;"
}