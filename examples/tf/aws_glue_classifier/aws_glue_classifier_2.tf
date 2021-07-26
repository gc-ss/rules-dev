resource "aws_glue_classifier" "example" {
  name = "example"

  json_classifier {
    json_path = "example"
  }
}