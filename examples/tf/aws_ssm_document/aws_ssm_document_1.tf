resource "aws_ssm_document" "test" {
  name          = "test_document"
  document_type = "Package"

  attachments_source {
    key    = "SourceUrl"
    values = ["s3://${aws_s3_bucket.object_bucket.bucket}/test.zip"]
  }

  # There is no AWS SSM API for reading attachments_source info directly
  lifecycle {
    ignore_changes = ["attachments_source"]
  }
}