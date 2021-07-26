resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = aws_vpc.example.cidr_block
  security_group_id = "sg-123456"
}