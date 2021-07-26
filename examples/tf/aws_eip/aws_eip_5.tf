resource "aws_eip" "byoip-ip" {
  vpc              = true
  public_ipv4_pool = "ipv4pool-ec2-012345"
}