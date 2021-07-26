resource "aws_kinesis_firehose_delivery_stream" "example" {
  # ... other configuration ...
  extended_s3_configuration {
    # Must be at least 64
    buffer_size = 128

    # ... other configuration ...
    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          hive_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          orc_ser_de {}
        }
      }

      schema_configuration {
        database_name = "${aws_glue_catalog_table.example.database_name}"
        role_arn      = "${aws_iam_role.example.arn}"
        table_name    = "${aws_glue_catalog_table.example.name}"
      }
    }
  }
}