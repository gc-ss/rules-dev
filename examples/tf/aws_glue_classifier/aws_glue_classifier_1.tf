resource "aws_glue_classifier" "example" {
  name = "example"

  grok_classifier {
    classification = "example"
    grok_pattern   = "example"
  }
}