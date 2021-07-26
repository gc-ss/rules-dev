resource "aws_backup_selection" "example" {
  iam_role_arn = "${aws_iam_role.example.arn}"
  name         = "tf_example_backup_selection"
  plan_id      = "${aws_backup_plan.example.id}"

  resources = [
    "${aws_db_instance.example.arn}",
    "${aws_ebs_volume.example.arn}",
    "${aws_efs_file_system.example.arn}",
  ]
}