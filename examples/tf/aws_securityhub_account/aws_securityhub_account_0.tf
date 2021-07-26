resource "aws_securityhub_account" "example" {}

resource "aws_securityhub_standards_subscription" "cis" {
  depends_on    = ["aws_securityhub_account.example"]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}

resource "aws_securityhub_standards_subscription" "pci_321" {
  depends_on    = ["aws_securityhub_account.example"]
  standards_arn = "arn:aws:securityhub:us-east-1::standards/pci-dss/v/3.2.1"
}