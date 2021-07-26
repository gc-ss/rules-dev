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