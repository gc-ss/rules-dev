resource "aws_guardduty_detector" "master" {
  enable = true
}

resource "aws_guardduty_detector" "member" {
  provider = "aws.dev"

  enable = true
}

resource "aws_guardduty_member" "member" {
  account_id         = "${aws_guardduty_detector.member.account_id}"
  detector_id        = "${aws_guardduty_detector.master.id}"
  email              = "required@example.com"
  invite             = true
  invitation_message = "please accept guardduty invitation"
}