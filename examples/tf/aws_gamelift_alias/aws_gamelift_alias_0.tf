resource "aws_gamelift_alias" "example" {
  name        = "example-alias"
  description = "Example Description"

  routing_strategy {
    message = "Example Message"
    type    = "TERMINAL"
  }
}