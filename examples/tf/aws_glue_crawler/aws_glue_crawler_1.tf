resource "aws_glue_crawler" "example" {
  database_name = "${aws_glue_catalog_database.example.name}"
  name          = "example"
  role          = "${aws_iam_role.example.arn}"

  jdbc_target {
    connection_name = "${aws_glue_connection.example.name}"
    path            = "database-name/%"
  }
}