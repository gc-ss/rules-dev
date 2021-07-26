resource "aws_wafregional_web_acl" "example" {
  # ... other configuration ...

  logging_configuration {
    log_destination = "${aws_kinesis_firehose_delivery_stream.example.arn}"

    redacted_fields {
      field_to_match {
        type = "URI"
      }

      field_to_match {
        data = "referer"
        type = "HEADER"
      }
    }
  }
}