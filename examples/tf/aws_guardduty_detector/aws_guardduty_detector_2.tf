resource "aws_guardduty_detector" "example" {
  enable = true
}

resource "aws_guardduty_organization_configuration" "example" {
  auto_enable = true
  detector_id = aws_guardduty_detector.example.id
}