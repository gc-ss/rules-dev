resource "aws_s3_bucket" "examplebucket" {
  bucket = "examplebuckettftest"
  acl    = "private"
}

resource "aws_s3_bucket_object" "examplebucket_object" {
  key                    = "someobject"
  bucket                 = "${aws_s3_bucket.examplebucket.id}"
  source                 = "index.html"
  server_side_encryption = "aws:kms"
}