resource "aws_lightsail_key_pair" "lg_key_pair" {
  name    = "lg_key_pair"
  pgp_key = "keybase:keybaseusername"
}