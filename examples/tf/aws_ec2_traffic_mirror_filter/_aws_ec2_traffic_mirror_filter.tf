

#---- 0 ----

resource "aws_ec2_traffic_mirror_filter" "filter" {
  description      = "traffic mirror filter - terraform example"
  network_services = ["amazon-dns"]
}

resource "aws_ec2_traffic_mirror_filter_rule" "ruleout" {
  description              = "test rule"
  traffic_mirror_filter_id = "${aws_ec2_traffic_mirror_filter.filter.id}"
  destination_cidr_block   = "10.0.0.0/8"
  source_cidr_block        = "10.0.0.0/8"
  rule_number              = 1
  rule_action              = "accept"
  traffic_direction        = "egress"
}

resource "aws_ec2_traffic_mirror_filter_rule" "rulein" {
  description              = "test rule"
  traffic_mirror_filter_id = "${aws_ec2_traffic_mirror_filter.filter.id}"
  destination_cidr_block   = "10.0.0.0/8"
  source_cidr_block        = "10.0.0.0/8"
  rule_number              = 1
  rule_action              = "accept"
  traffic_direction        = "ingress"
  protocol                 = 6

  destination_port_range {
    from_port = 22
    to_port   = 53
  }

  source_port_range {
    from_port = 0
    to_port   = 10
  }
}

#---- 1 ----

resource "aws_ec2_traffic_mirror_filter" "filter" {
  description      = "traffic mirror filter - terraform example"
  network_services = ["amazon-dns"]
}

resource "aws_ec2_traffic_mirror_target" "target" {
  network_load_balancer_arn = "${aws_lb.lb.arn}"
}

resource "aws_ec2_traffic_mirror_session" "session" {
  description              = "traffic mirror session - terraform example"
  network_interface_id     = "${aws_instance.test.primary_network_interface_id}"
  traffic_mirror_filter_id = "${aws_ec2_traffic_mirror_filter.filter.id}"
  traffic_mirror_target_id = "${aws_ec2_traffic_mirror_target.target.id}"
}

#---- 2 ----

resource "aws_ec2_traffic_mirror_filter" "foo" {
  description      = "traffic mirror filter - terraform example"
  network_services = ["amazon-dns"]
}