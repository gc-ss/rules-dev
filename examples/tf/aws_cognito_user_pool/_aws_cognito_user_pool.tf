

#---- 0 ----

resource "aws_cognito_user_pool" "main" {
  name = "identity pool"
}

resource "aws_iam_role" "group_role" {
  name = "user-group-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "us-east-1:12345678-dead-beef-cafe-123456790ab"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_cognito_user_group" "main" {
  name         = "user-group"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
  description  = "Managed by Terraform"
  precedence   = 42
  role_arn     = "${aws_iam_role.group_role.arn}"
}

#---- 1 ----

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "https://example.com"
  name       = "example"

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

#---- 2 ----

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "https://example.com"
  name       = "example"

  scope {
    scope_name        = "sample-scope"
    scope_description = "a Sample Scope Description"
  }

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

#---- 3 ----

resource "aws_cognito_user_pool" "example" {
  name                     = "example-pool"
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_identity_provider" "example_provider" {
  user_pool_id  = "${aws_cognito_user_pool.example.id}"
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email"
    client_id        = "your client_id"
    client_secret    = "your client_secret"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

#---- 4 ----

resource "aws_cognito_user_pool" "pool" {
  name = "mypool"
}

#---- 5 ----

resource "aws_cognito_user_pool" "example" {
  # ... other configuration ...

  mfa_configuration          = "ON"
  sms_authentication_message = "Your code is {####}"

  sms_configuration {
    external_id    = "example"
    sns_caller_arn = aws_iam_role.example.arn
  }

  software_token_mfa_configuration {
    enabled = true
  }
}

#---- 6 ----

resource "aws_cognito_user_pool" "example" {
  # ... other configuration ...

  schema {
    name                     = "<name>"
    attribute_data_type      = "<appropriate type>"
    developer_only_attribute = false
    mutable                  = true  // false for "sub"
    required                 = false // true for "sub"
    string_attribute_constraints {   // if it is a string
      min_length = 0                 // 10 for "birthdate"
      max_length = 2048              // 10 for "birthdate"
    }
  }
}

#---- 7 ----

resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  # Other parameters
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = "${aws_lb_listener.front_end.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static.arn}"
  }

  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}

# Forward action

resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = "${aws_lb_listener.front_end.arn}"
  priority     = 99

  action {
    type = "forward"
    forward {
      target_group {
        arn    = "${aws_lb_target_group.main.arn}"
        weight = 80
      }

      target_group {
        arn    = "${aws_lb_target_group.canary.arn}"
        weight = 20
      }

      stickiness {
        enabled  = true
        duration = 600
      }

    }
  }

  condition {
    host_header {
      values = ["my-service.*.terraform.io"]
    }
  }
}

# Weighted Forward action

resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = "${aws_lb_listener.front_end.arn}"
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static.arn}"
  }

  condition {
    host_header {
      values = ["my-service.*.terraform.io"]
    }
  }
}

# Redirect action

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = "${aws_lb_listener.front_end.arn}"

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    http_header {
      http_header_name = "X-Forwarded-For"
      values           = ["192.168.1.*"]
    }
  }
}

# Fixed-response action

resource "aws_lb_listener_rule" "health_check" {
  listener_arn = "${aws_lb_listener.front_end.arn}"

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code  = "200"
    }
  }

  condition {
    query_string {
      key   = "health"
      value = "check"
    }

    query_string {
      value = "bar"
    }
  }
}

# Authenticate-cognito Action

resource "aws_cognito_user_pool" "pool" {
  # ...
}

resource "aws_cognito_user_pool_client" "client" {
  # ...
}

resource "aws_cognito_user_pool_domain" "domain" {
  # ...
}

resource "aws_lb_listener_rule" "admin" {
  listener_arn = "${aws_lb_listener.front_end.arn}"

  action {
    type = "authenticate-cognito"

    authenticate_cognito {
      user_pool_arn       = "${aws_cognito_user_pool.pool.arn}"
      user_pool_client_id = "${aws_cognito_user_pool_client.client.id}"
      user_pool_domain    = "${aws_cognito_user_pool_domain.domain.domain}"
    }
  }

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static.arn}"
  }
}

# Authenticate-oidc Action

resource "aws_lb_listener_rule" "admin" {
  listener_arn = "${aws_lb_listener.front_end.arn}"

  action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = "https://example.com/authorization_endpoint"
      client_id              = "client_id"
      client_secret          = "client_secret"
      issuer                 = "https://example.com"
      token_endpoint         = "https://example.com/token_endpoint"
      user_info_endpoint     = "https://example.com/user_info_endpoint"
    }
  }

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static.arn}"
  }
}

#---- 8 ----

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

#---- 9 ----

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = "${aws_cognito_user_pool.pool.id}"

  generate_secret     = true
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
}

#---- 10 ----

data "aws_caller_identity" "current" {}

resource "aws_cognito_user_pool" "test" {
  name = "pool"
}

resource "aws_pinpoint_app" "test" {
  name = "pinpoint"
}

resource "aws_iam_role" "test" {
  name = "role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cognito-idp.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "test" {
  name = "role_policy"
  role = "${aws_iam_role.test.id}"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "mobiletargeting:UpdateEndpoint",
          "mobiletargeting:PutItems"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:mobiletargeting:*:${data.aws_caller_identity.current.account_id}:apps/${aws_pinpoint_app.test.application_id}*"
      }
    ]
  }
  EOF
}

resource "aws_cognito_user_pool_client" "test" {
  name         = "pool_client"
  user_pool_id = "${aws_cognito_user_pool.test.id}"

  analytics_configuration {
    application_id   = "${aws_pinpoint_app.test.application_id}"
    external_id      = "some_id"
    role_arn         = "${aws_iam_role.test.arn}"
    user_data_shared = true
  }
}

#---- 11 ----

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "example-domain"
  user_pool_id = "${aws_cognito_user_pool.example.id}"
}

resource "aws_cognito_user_pool" "example" {
  name = "example-pool"
}

#---- 12 ----

resource "aws_cognito_user_pool_domain" "main" {
  domain          = "example-domain.example.com"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  user_pool_id    = "${aws_cognito_user_pool.example.id}"
}

resource "aws_cognito_user_pool" "example" {
  name = "example-pool"
}

data "aws_route53_zone" "example" {
  name = "example.com"
}

resource "aws_route53_record" "auth-cognito-A" {
  name    = "${aws_cognito_user_pool_domain.main.domain}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.example.zone_id}"
  alias {
    evaluate_target_health = false
    name                   = "${aws_cognito_user_pool_domain.main.cloudfront_distribution_arn}"
    // This zone_id is fixed
    zone_id = "Z2FDTNDATAQYW2"
  }
}

#---- 13 ----

resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_target_group" "front_end" {
  # ...
}

resource "aws_cognito_user_pool" "pool" {
  # ...
}

resource "aws_cognito_user_pool_client" "client" {
  # ...
}

resource "aws_cognito_user_pool_domain" "domain" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "authenticate-cognito"

    authenticate_cognito {
      user_pool_arn       = "${aws_cognito_user_pool.pool.arn}"
      user_pool_client_id = "${aws_cognito_user_pool_client.client.id}"
      user_pool_domain    = "${aws_cognito_user_pool_domain.domain.domain}"
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
  }
}