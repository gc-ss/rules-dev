resource "aws_budgets_budget" "cost" {
  # ...
  budget_type  = "COST"
  limit_amount = "100"
  limit_unit   = "USD"
}