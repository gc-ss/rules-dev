

#---- 0 ----

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

#---- 1 ----

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