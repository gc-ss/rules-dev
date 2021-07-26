resource "aws_glue_classifier" "example" {
  name = "example"

  xml_classifier {
    classification = "example"
    row_tag        = "example"
  }
}