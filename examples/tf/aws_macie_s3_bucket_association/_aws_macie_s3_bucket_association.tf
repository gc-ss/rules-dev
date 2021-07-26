

#---- 0 ----

resource "aws_macie_s3_bucket_association" "example" {
  bucket_name = "tf-macie-example"
  prefix      = "data"

  classification_type {
    one_time = "FULL"
  }
}