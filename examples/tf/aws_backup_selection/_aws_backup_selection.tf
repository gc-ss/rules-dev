

#---- 0 ----

resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = "${aws_iam_role.example.name}"
}

resource "aws_backup_selection" "example" {
  # ... other configuration ...

  iam_role_arn = "${aws_iam_role.example.arn}"
}

#---- 1 ----

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

#---- 2 ----

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