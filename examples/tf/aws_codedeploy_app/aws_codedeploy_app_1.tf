resource "aws_codedeploy_app" "example" {
  compute_platform = "Lambda"
  name             = "example"
}