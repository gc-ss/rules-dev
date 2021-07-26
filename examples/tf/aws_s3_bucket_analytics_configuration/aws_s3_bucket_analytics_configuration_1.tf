resource "aws_s3_bucket_analytics_configuration" "example-filtered" {
  bucket = aws_s3_bucket.example.bucket
  name   = "ImportantBlueDocuments"

  filter {
    prefix = "documents/"

    tags = {
      priority = "high"
      class    = "blue"
    }
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}