variable "extra_tags" {
  default = [
    {
      key                 = "Foo"
      value               = "Bar"
      propagate_at_launch = true
    },
    {
      key                 = "Baz"
      value               = "Bam"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscaling_group" "bar" {
  name                 = "foobar3-terraform-test"
  max_size             = 5
  min_size             = 2
  launch_configuration = "${aws_launch_configuration.foobar.name}"
  vpc_zone_identifier  = ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"]

  tags = ["${concat(
    list(
      map("key", "interpolation1", "value", "value3", "propagate_at_launch", true),
      map("key", "interpolation2", "value", "value4", "propagate_at_launch", true)
    ),
    var.extra_tags)
  }"]
}