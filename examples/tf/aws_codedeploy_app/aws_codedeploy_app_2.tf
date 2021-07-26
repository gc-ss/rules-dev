resource "aws_codedeploy_app" "example" {
  compute_platform = "Server"
  name             = "example"
}