resource "aws_route53_health_check" "parent" {
  type                   = "CALCULATED"
  child_health_threshold = 1
  child_healthchecks     = ["${aws_route53_health_check.child.id}"]

  tags = {
    Name = "tf-test-calculated-health-check"
  }
}