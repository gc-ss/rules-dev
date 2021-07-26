

#---- 0 ----

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

#---- 1 ----

resource "aws_guardduty_detector" "master" {
  enable = true
}

resource "aws_s3_bucket" "bucket" {
  acl = "private"
}

resource "aws_s3_bucket_object" "MyThreatIntelSet" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = "${aws_s3_bucket.bucket.id}"
  key     = "MyThreatIntelSet"
}

resource "aws_guardduty_threatintelset" "MyThreatIntelSet" {
  activate    = true
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyThreatIntelSet.bucket}/${aws_s3_bucket_object.MyThreatIntelSet.key}"
  name        = "MyThreatIntelSet"
}

#---- 2 ----

resource "aws_guardduty_detector" "example" {
  enable = true
}

resource "aws_guardduty_organization_configuration" "example" {
  auto_enable = true
  detector_id = aws_guardduty_detector.example.id
}

#---- 3 ----

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

#---- 4 ----

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_guardduty_detector" "example" {}

resource "aws_guardduty_organization_admin_account" "example" {
  depends_on = [aws_organizations_organization.example]

  admin_account_id = "123456789012"
}

#---- 5 ----

resource "aws_guardduty_detector" "master" {
  enable = true
}

resource "aws_s3_bucket" "bucket" {
  acl = "private"
}

resource "aws_s3_bucket_object" "MyIPSet" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = "${aws_s3_bucket.bucket.id}"
  key     = "MyIPSet"
}

resource "aws_guardduty_ipset" "MyIPSet" {
  activate    = true
  detector_id = "${aws_guardduty_detector.master.id}"
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${aws_s3_bucket_object.MyIPSet.bucket}/${aws_s3_bucket_object.MyIPSet.key}"
  name        = "MyIPSet"
}

#---- 6 ----

resource "aws_guardduty_detector" "MyDetector" {
  enable = true
}