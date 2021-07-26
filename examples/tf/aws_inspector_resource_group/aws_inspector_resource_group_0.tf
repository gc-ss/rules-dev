resource "aws_inspector_resource_group" "example" {
  tags = {
    Name = "foo"
    Env  = "bar"
  }
}