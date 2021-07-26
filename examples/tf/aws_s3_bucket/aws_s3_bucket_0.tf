resource "aws_s3_bucket_analytics_configuration" "example-entire-bucket" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"

  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_arn = aws_s3_bucket.analytics.arn
        }
      }
    }
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_bucket" "analytics" {
  bucket = "analytics destination"
}