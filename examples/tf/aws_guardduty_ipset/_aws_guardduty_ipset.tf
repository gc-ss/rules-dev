

#---- 0 ----

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