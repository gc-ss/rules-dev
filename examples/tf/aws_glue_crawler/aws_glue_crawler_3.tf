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