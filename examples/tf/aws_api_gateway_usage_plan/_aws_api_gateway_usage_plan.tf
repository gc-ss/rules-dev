

#---- 0 ----

resource "aws_api_gateway_rest_api" "myapi" {
  name = "MyDemoAPI"
}

# ...

resource "aws_api_gateway_deployment" "dev" {
  rest_api_id = "${aws_api_gateway_rest_api.myapi.id}"
  stage_name  = "dev"
}

resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = "${aws_api_gateway_rest_api.myapi.id}"
  stage_name  = "prod"
}

resource "aws_api_gateway_usage_plan" "MyUsagePlan" {
  name         = "my-usage-plan"
  description  = "my description"
  product_code = "MYCODE"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.myapi.id}"
    stage  = "${aws_api_gateway_deployment.dev.stage_name}"
  }

  api_stages {
    api_id = "${aws_api_gateway_rest_api.myapi.id}"
    stage  = "${aws_api_gateway_deployment.prod.stage_name}"
  }

  quota_settings {
    limit  = 20
    offset = 2
    period = "WEEK"
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

#---- 1 ----

resource "aws_api_gateway_rest_api" "test" {
  name = "MyDemoAPI"
}

# ...

resource "aws_api_gateway_usage_plan" "myusageplan" {
  name = "my_usage_plan"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.test.id}"
    stage  = "${aws_api_gateway_deployment.foo.stage_name}"
  }
}

resource "aws_api_gateway_api_key" "mykey" {
  name = "my_key"
}

resource "aws_api_gateway_usage_plan_key" "main" {
  key_id        = "${aws_api_gateway_api_key.mykey.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.myusageplan.id}"
}