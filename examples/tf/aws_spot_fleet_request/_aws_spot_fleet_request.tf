

#---- 0 ----

# Request a Spot fleet
resource "aws_spot_fleet_request" "cheap_compute" {
  iam_fleet_role      = "arn:aws:iam::12345678:role/spot-fleet"
  spot_price          = "0.03"
  allocation_strategy = "diversified"
  target_capacity     = 6
  valid_until         = "2019-11-04T20:44:20Z"

  launch_specification {
    instance_type            = "m4.10xlarge"
    ami                      = "ami-1234"
    spot_price               = "2.793"
    placement_tenancy        = "dedicated"
    iam_instance_profile_arn = "${aws_iam_instance_profile.example.arn}"
  }

  launch_specification {
    instance_type            = "m4.4xlarge"
    ami                      = "ami-5678"
    key_name                 = "my-key"
    spot_price               = "1.117"
    iam_instance_profile_arn = "${aws_iam_instance_profile.example.arn}"
    availability_zone        = "us-west-1a"
    subnet_id                = "subnet-1234"
    weighted_capacity        = 35

    root_block_device {
      volume_size = "300"
      volume_type = "gp2"
    }

    tags = {
      Name = "spot-fleet-example"
    }
  }
}

#---- 1 ----

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
  }

  depends_on = ["aws_iam_policy_attachment.test-attach"]
}

#---- 2 ----

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

#---- 3 ----

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