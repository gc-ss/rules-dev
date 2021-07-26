

#---- 0 ----

resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = "My App Portfolio"
  description   = "List of my organizations apps"
  provider_name = "Brett"
}