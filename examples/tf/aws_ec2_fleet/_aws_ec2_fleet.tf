

#---- 0 ----

resource "aws_ec2_fleet" "example" {
  launch_template_config {
    launch_template_specification {
      launch_template_id = "${aws_launch_template.example.id}"
      version            = "${aws_launch_template.example.latest_version}"
    }
  }

  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = 5
  }
}

#---- 1 ----

resource "aws_ec2_fleet" "example" {
  # ... other configuration ...

  launch_template_config {
    # ... other configuration ...

    override {
      instance_type     = "m4.xlarge"
      weighted_capacity = 1
    }

    override {
      instance_type     = "m4.2xlarge"
      weighted_capacity = 2
    }
  }
}