

#---- 0 ----

resource "aws_ec2_availability_zone_group" "example" {
  group_name    = "us-west-2-lax-1"
  opt_in_status = "opted-in"
}