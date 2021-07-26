resource "aws_wafregional_ipset" "ipset" {
  name = "tfIPSet"

  ip_set_descriptor {
    type  = "IPV4"
    value = "192.0.7.0/24"
  }
}

resource "aws_wafregional_rule" "foo" {
  name        = "tfWAFRule"
  metric_name = "tfWAFRule"

  predicate {
    data_id = "${aws_wafregional_ipset.ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_web_acl" "foo" {
  name        = "foo"
  metric_name = "foo"

  default_action {
    type = "ALLOW"
  }

  rule {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_wafregional_rule.foo.id}"
  }
}
resource "aws_api_gateway_rest_api" "test" {
  name = "foo"
}

resource "aws_api_gateway_resource" "test" {
  parent_id   = "${aws_api_gateway_rest_api.test.root_resource_id}"
  path_part   = "test"
  rest_api_id = "${aws_api_gateway_rest_api.test.id}"
}

resource "aws_api_gateway_method" "test" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = "${aws_api_gateway_resource.test.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.test.id}"
}

resource "aws_api_gateway_method_response" "test" {
  http_method = "${aws_api_gateway_method.test.http_method}"
  resource_id = "${aws_api_gateway_resource.test.id}"
  rest_api_id = "${aws_api_gateway_rest_api.test.id}"
  status_code = "400"
}

resource "aws_api_gateway_integration" "test" {
  http_method             = "${aws_api_gateway_method.test.http_method}"
  integration_http_method = "GET"
  resource_id             = "${aws_api_gateway_resource.test.id}"
  rest_api_id             = "${aws_api_gateway_rest_api.test.id}"
  type                    = "HTTP"
  uri                     = "http://www.example.com"
}

resource "aws_api_gateway_integration_response" "test" {
  rest_api_id = "${aws_api_gateway_rest_api.test.id}"
  resource_id = "${aws_api_gateway_resource.test.id}"
  http_method = "${aws_api_gateway_integration.test.http_method}"
  status_code = "${aws_api_gateway_method_response.test.status_code}"
}

resource "aws_api_gateway_deployment" "test" {
  depends_on = ["aws_api_gateway_integration_response.test"]

  rest_api_id = "${aws_api_gateway_rest_api.test.id}"
}

resource "aws_api_gateway_stage" "test" {
  deployment_id = "${aws_api_gateway_deployment.test.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.test.id}"
  stage_name    = "test"
}


resource "aws_wafregional_web_acl_association" "association" {
  resource_arn = "${aws_api_gateway_stage.test.arn}"
  web_acl_id   = "${aws_wafregional_web_acl.foo.id}"
}