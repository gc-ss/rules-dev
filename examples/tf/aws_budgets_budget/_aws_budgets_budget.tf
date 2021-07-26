

#---- 0 ----

resource "aws_budgets_budget" "ec2" {
  name              = "budget-ec2-monthly"
  budget_type       = "COST"
  limit_amount      = "1200"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"

  cost_filters = {
    Service = "Amazon Elastic Compute Cloud - Compute"
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["test@example.com"]
  }
}

#---- 1 ----

resource "aws_budgets_budget" "cost" {
  # ...
  budget_type  = "COST"
  limit_amount = "100"
  limit_unit   = "USD"
}

#---- 2 ----

resource "aws_budgets_budget" "s3" {
  # ...
  budget_type  = "USAGE"
  limit_amount = "3"
  limit_unit   = "GB"
}

#---- 3 ----

resource "aws_budgets_budget" "savings_plan_utilization" {
  # ...
  budget_type  = "SAVINGS_PLANS_UTILIZATION"
  limit_amount = "100.0"
  limit_unit   = "PERCENTAGE"

  cost_types {
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_blended                = false
  }
}

#---- 4 ----

resource "aws_budgets_budget" "ri_utilization" {
  # ...
  budget_type  = "RI_UTILIZATION"
  limit_amount = "100.0" # RI utilization must be 100
  limit_unit   = "PERCENTAGE"

  #Cost types must be defined for RI budgets because the settings conflict with the defaults
  cost_types {
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_blended                = false
  }

  # RI Utilization plans require a service cost filter to be set
  cost_filters = {
    Service = "Amazon Relational Database Service"
  }
}