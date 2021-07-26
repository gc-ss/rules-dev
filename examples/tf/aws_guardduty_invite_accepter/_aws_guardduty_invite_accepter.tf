

#---- 0 ----

resource "aws_guardduty_detector" "master" {}

resource "aws_guardduty_detector" "member" {
  provider = "aws.dev"
}

resource "aws_guardduty_member" "dev" {
  account_id  = "${aws_guardduty_detector.member.account_id}"
  detector_id = "${aws_guardduty_detector.master.id}"
  email       = "required@example.com"
  invite      = true
}

resource "aws_guardduty_invite_accepter" "member" {
  depends_on = ["aws_guardduty_member.dev"]
  provider   = "aws.dev"

  detector_id       = "${aws_guardduty_detector.member.id}"
  master_account_id = "${aws_guardduty_detector.master.account_id}"
}