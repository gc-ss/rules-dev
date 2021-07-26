resource "aws_wafregional_web_acl" "example" {
  name        = "example"
  metric_name = "example"

  default_action {
    type = "ALLOW"
  }

  rule {
    priority = 1
    rule_id  = "${aws_wafregional_rule_group.example.id}"
    type     = "GROUP"

    override_action {
      type = "NONE"
    }
  }
}