resource "aws_ec2_traffic_mirror_filter" "foo" {
  description      = "traffic mirror filter - terraform example"
  network_services = ["amazon-dns"]
}