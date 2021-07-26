

#---- 0 ----

resource "aws_s3_bucket" "test" {
  bucket = "my-tf-test-bucket"
}

resource "aws_s3_bucket" "inventory" {
  bucket = "my-tf-inventory-bucket"
}

resource "aws_s3_bucket_inventory" "test" {
  bucket = "${aws_s3_bucket.test.id}"
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Daily"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = "${aws_s3_bucket.inventory.arn}"
    }
  }
}

#---- 1 ----

resource "aws_s3_bucket" "test" {
  bucket = "my-tf-test-bucket"
}

resource "aws_s3_bucket" "inventory" {
  bucket = "my-tf-inventory-bucket"
}

resource "aws_s3_bucket_inventory" "test-prefix" {
  bucket = "${aws_s3_bucket.test.id}"
  name   = "DocumentsWeekly"

  included_object_versions = "All"

  schedule {
    frequency = "Daily"
  }

  filter {
    prefix = "documents/"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = "${aws_s3_bucket.inventory.arn}"
      prefix     = "inventory"
    }
  }
}