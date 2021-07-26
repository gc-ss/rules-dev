

#---- 0 ----

resource "aws_securityhub_account" "example" {}

resource "aws_securityhub_standards_subscription" "cis" {
  depends_on    = ["aws_securityhub_account.example"]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}

resource "aws_securityhub_standards_subscription" "pci_321" {
  depends_on    = ["aws_securityhub_account.example"]
  standards_arn = "arn:aws:securityhub:us-east-1::standards/pci-dss/v/3.2.1"
}

#---- 1 ----

resource "aws_securityhub_account" "example" {}

#---- 2 ----

resource "aws_securityhub_account" "example" {}

resource "aws_securityhub_member" "example" {
  depends_on = ["aws_securityhub_account.example"]
  account_id = "123456789012"
  email      = "example@example.com"
  invite     = true
}

#---- 3 ----

resource "aws_securityhub_account" "example" {}

data "aws_region" "current" {}

resource "aws_securityhub_product_subscription" "example" {
  depends_on  = ["aws_securityhub_account.example"]
  product_arn = "arn:aws:securityhub:${data.aws_region.current.name}:733251395267:product/alertlogic/althreatmanagement"
}