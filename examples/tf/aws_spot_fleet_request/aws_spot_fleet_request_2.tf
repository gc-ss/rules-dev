resource "aws_spot_fleet_request" "foo" {
  iam_fleet_role  = "arn:aws:iam::12345678:role/spot-fleet"
  spot_price      = "0.005"
  target_capacity = 2
  valid_until     = "2019-11-04T20:44:20Z"

  launch_specification {
    instance_type     = "m1.small"
    ami               = "ami-d06a90b0"
    key_name          = "my-key"
    availability_zone = "us-west-2a"
  }

  launch_specification {
    instance_type     = "m5.large"
    ami               = "ami-d06a90b0"
    key_name          = "my-key"
    availability_zone = "us-west-2a"
  }
}