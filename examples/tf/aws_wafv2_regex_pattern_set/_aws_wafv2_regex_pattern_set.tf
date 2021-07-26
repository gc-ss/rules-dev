

#---- 0 ----

resource "aws_wafv2_regex_pattern_set" "example" {
  name        = "example"
  description = "Example regex pattern set"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "one"
  }

  regular_expression {
    regex_string = "two"
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}

#---- 1 ----

resource "aws_wafv2_ip_set" "test" {
  name               = "test"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["1.1.1.1/32", "2.2.2.2/32"]
}

resource "aws_wafv2_regex_pattern_set" "test" {
  name  = "test"
  scope = "REGIONAL"

  regular_expression_list {
    regex_string = "one"
  }
}

resource "aws_wafv2_rule_group" "example" {
  name        = "complex-example"
  description = "An rule group containing all statements"
  scope       = "REGIONAL"
  capacity    = 500

  rule {
    name     = "rule-1"
    priority = 1

    action {
      block {}
    }

    statement {

      not_statement {
        statement {

          and_statement {
            statement {

              geo_match_statement {
                country_codes = ["US"]
              }
            }

            statement {

              byte_match_statement {
                positional_constraint = "CONTAINS"
                search_string         = "word"

                field_to_match {
                  all_query_arguments {}
                }

                text_transformation {
                  priority = 5
                  type     = "CMD_LINE"
                }

                text_transformation {
                  priority = 2
                  type     = "LOWERCASE"
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-1"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "rule-2"
    priority = 2

    action {
      count {}
    }

    statement {

      or_statement {
        statement {

          sqli_match_statement {

            field_to_match {
              body {}
            }

            text_transformation {
              priority = 5
              type     = "URL_DECODE"
            }

            text_transformation {
              priority = 4
              type     = "HTML_ENTITY_DECODE"
            }

            text_transformation {
              priority = 3
              type     = "COMPRESS_WHITE_SPACE"
            }
          }
        }

        statement {

          xss_match_statement {

            field_to_match {
              method {}
            }

            text_transformation {
              priority = 2
              type     = "NONE"
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-2"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "rule-3"
    priority = 3

    action {
      block {}
    }

    statement {

      size_constraint_statement {
        comparison_operator = "GT"
        size                = 100

        field_to_match {
          single_query_argument {
            name = "username"
          }
        }

        text_transformation {
          priority = 5
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-3"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "rule-4"
    priority = 4

    action {
      block {}
    }

    statement {

      or_statement {
        statement {

          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.test.arn
          }
        }

        statement {

          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.test.arn

            field_to_match {
              single_header {
                name = "referer"
              }
            }

            text_transformation {
              priority = 2
              type     = "NONE"
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-4"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }

  tags = {
    "Name" = "example-and-statement"
    "Code" = "123456"
  }
}