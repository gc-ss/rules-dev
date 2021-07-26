resource "aws_lambda_alias" "test_lambda_alias" {
  name             = "my_alias"
  description      = "a sample description"
  function_name    = "${aws_lambda_function.lambda_function_test.arn}"
  function_version = "1"

  routing_config = {
    additional_version_weights = {
      "2" = 0.5
    }
  }
}