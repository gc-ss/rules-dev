

#---- 0 ----

resource "aws_backup_plan" "example" {
  name = "tf_example_backup_plan"

  rule {
    rule_name         = "tf_example_backup_rule"
    target_vault_name = "${aws_backup_vault.test.name}"
    schedule          = "cron(0 12 * * ? *)"
  }
}