

#---- 0 ----

resource "aws_s3_bucket" "default" {
  bucket = "tf-spot-datafeed"
}

resource "aws_spot_datafeed_subscription" "default" {
  bucket = "${aws_s3_bucket.default.bucket}"
  prefix = "my_subdirectory"
}