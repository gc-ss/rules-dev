resource "aws_backup_selection" "example" {
  iam_role_arn = "${aws_iam_role.example.arn}"
  name         = "tf_example_backup_selection"
  plan_id      = "${aws_backup_plan.example.id}"

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "foo"
    value = "bar"
  }
}