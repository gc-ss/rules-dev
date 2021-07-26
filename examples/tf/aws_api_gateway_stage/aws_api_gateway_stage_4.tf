variable "stage_name" {
  default = "example"
  type    = "string"
}

resource "aws_api_gateway_rest_api" "example" {
  # ... other configuration ...
}

resource "aws_api_gateway_stage" "example" {
  depends_on = ["aws_cloudwatch_log_group.example"]

  name = "${var.stage_name}"

  # ... other configuration ...
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.example.id}/${var.stage_name}"
  retention_in_days = 7

  # ... potentially other configuration ...
}