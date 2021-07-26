resource "aws_waf_rule" "example" {
  name        = "example"
  metric_name = "example"
}

resource "aws_waf_rule_group" "example" {
  name        = "example"
  metric_name = "example"

  activated_rule {
    action {
      type = "COUNT"
    }

    priority = 50
    rule_id  = "${aws_waf_rule.example.id}"
  }
}