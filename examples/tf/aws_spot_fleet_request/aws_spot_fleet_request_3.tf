data "aws_subnet_ids" "example" {
  vpc_id = "${var.vpc_id}"
}

resource "aws_launch_template" "foo" {
  name          = "launch-template"
  image_id      = "ami-516b9131"
  instance_type = "m1.small"
  key_name      = "some-key"
  spot_price    = "0.05"
}

resource "aws_spot_fleet_request" "foo" {
  iam_fleet_role  = "arn:aws:iam::12345678:role/spot-fleet"
  spot_price      = "0.005"
  target_capacity = 2
  valid_until     = "2019-11-04T20:44:20Z"

  launch_template_config {
    launch_template_specification {
      id      = "${aws_launch_template.foo.id}"
      version = "${aws_launch_template.foo.latest_version}"
    }
    overrides {
      subnet_id = "${data.aws_subnets.example.ids[0]}"
    }
    overrides {
      subnet_id = "${data.aws_subnets.example.ids[1]}"
    }
    overrides {
      subnet_id = "${data.aws_subnets.example.ids[2]}"
    }
  }

  depends_on = ["aws_iam_policy_attachment.test-attach"]
}