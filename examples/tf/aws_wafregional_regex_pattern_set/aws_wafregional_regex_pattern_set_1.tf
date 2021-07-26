resource "aws_wafregional_regex_pattern_set" "example" {
  name                  = "example"
  regex_pattern_strings = ["one", "two"]
}