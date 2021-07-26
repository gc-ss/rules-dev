

#---- 0 ----

resource "aws_glue_crawler" "example" {
  database_name = "${aws_glue_catalog_database.example.name}"
  name          = "example"
  role          = "${aws_iam_role.example.arn}"

  dynamodb_target {
    path = "table-name"
  }
}

#---- 1 ----

resource "aws_glue_crawler" "example" {
  database_name = "${aws_glue_catalog_database.example.name}"
  name          = "example"
  role          = "${aws_iam_role.example.arn}"

  jdbc_target {
    connection_name = "${aws_glue_connection.example.name}"
    path            = "database-name/%"
  }
}

#---- 2 ----

resource "aws_glue_crawler" "example" {
  database_name = "${aws_glue_catalog_database.example.name}"
  name          = "example"
  role          = "${aws_iam_role.example.arn}"

  s3_target {
    path = "s3://${aws_s3_bucket.example.bucket}"
  }
}

#---- 3 ----

resource "aws_glue_crawler" "example" {
  database_name = "${aws_glue_catalog_database.example.name}"
  name          = "example"
  role          = "${aws_iam_role.example.arn}"

  catalog_target {
    database_name = "${aws_glue_catalog_database.example.name}"
    tables        = ["${aws_glue_catalog_table.example.name}"]
  }

  schema_change_policy {
    delete_behavior = "LOG"
  }

  configuration = <<EOF
{
  "Version":1.0,
  "Grouping": {
    "TableGroupingPolicy": "CombineCompatibleSchemas"
  }
}
EOF
}