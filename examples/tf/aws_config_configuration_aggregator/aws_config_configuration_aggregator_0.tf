resource "aws_config_configuration_aggregator" "account" {
  name = "example"

  account_aggregation_source {
    account_ids = ["123456789012"]
    regions     = ["us-west-2"]
  }
}