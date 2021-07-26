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