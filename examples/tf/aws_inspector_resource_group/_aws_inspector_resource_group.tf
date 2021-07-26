

#---- 0 ----

resource "aws_inspector_resource_group" "example" {
  tags = {
    Name = "foo"
    Env  = "bar"
  }
}

#---- 1 ----

resource "aws_inspector_resource_group" "bar" {
  tags = {
    Name = "foo"
    Env  = "bar"
  }
}

resource "aws_inspector_assessment_target" "foo" {
  name               = "assessment target"
  resource_group_arn = "${aws_inspector_resource_group.bar.arn}"
}