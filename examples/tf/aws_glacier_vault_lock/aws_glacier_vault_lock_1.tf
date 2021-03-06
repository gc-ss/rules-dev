resource "aws_glacier_vault_lock" "example" {
  complete_lock = true
  policy        = "${data.aws_iam_policy_document.example.json}"
  vault_name    = "${aws_glacier_vault.example.name}"
}