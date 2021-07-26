

#---- 0 ----

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

#---- 1 ----

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

#---- 2 ----

resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-1a2b3c"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = "${aws_launch_template.foobar.id}"
    version = "$Latest"
  }
}

#---- 3 ----

resource "aws_launch_template" "example" {
  name_prefix   = "example"
  image_id      = "${data.aws_ami.example.id}"
  instance_type = "c5.large"
}

resource "aws_autoscaling_group" "example" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.example.id}"
      }

      override {
        instance_type     = "c4.large"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "c3.large"
        weighted_capacity = "2"
      }
    }
  }
}

#---- 4 ----

resource "aws_launch_template" "foo" {
  name = "foo"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 4
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = true

  ebs_optimized = true

  elastic_gpu_specifications {
    type = "test"
  }

  elastic_inference_accelerator {
    type = "eia1.medium"
  }

  iam_instance_profile {
    name = "test"
  }

  image_id = "ami-test"

  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t2.micro"

  kernel_id = "test"

  key_name = "test"

  license_specification {
    license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "us-west-2a"
  }

  ram_disk_id = "test"

  vpc_security_group_ids = ["sg-12345678"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}