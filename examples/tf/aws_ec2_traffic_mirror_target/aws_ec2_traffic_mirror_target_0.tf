resource "aws_ec2_traffic_mirror_target" "nlb" {
  description               = "NLB target"
  network_load_balancer_arn = "${aws_lb.lb.arn}"
}

resource "aws_ec2_traffic_mirror_target" "eni" {
  description          = "ENI target"
  network_interface_id = "${aws_instance.test.primary_network_interface_id}"
}
