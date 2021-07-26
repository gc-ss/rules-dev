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