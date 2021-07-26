

#---- 0 ----

resource "aws_apigatewayv2_vpc_link" "example" {
  name               = "example"
  security_group_ids = [data.aws_security_group.example.id]
  subnet_ids         = data.aws_subnet_ids.example.ids

  tags = {
    Usage = "example"
  }
}