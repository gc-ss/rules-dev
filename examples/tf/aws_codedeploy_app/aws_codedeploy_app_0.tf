resource "aws_codedeploy_app" "example" {
  compute_platform = "ECS"
  name             = "example"
}