resource "aws_cloudfront_distribution" "example" {
  # ... other configuration ...

  # lambda_function_association is also supported by default_cache_behavior
  ordered_cache_behavior {
    # ... other configuration ...

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = "${aws_lambda_function.example.qualified_arn}"
      include_body = false
    }
  }
}