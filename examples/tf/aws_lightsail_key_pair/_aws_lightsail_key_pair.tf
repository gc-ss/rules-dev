

#---- 0 ----

# Create a new Lightsail Key Pair
resource "aws_lightsail_key_pair" "lg_key_pair" {
  name = "lg_key_pair"
}

#---- 1 ----

resource "aws_lightsail_key_pair" "lg_key_pair" {
  name    = "lg_key_pair"
  pgp_key = "keybase:keybaseusername"
}

#---- 2 ----

resource "aws_lightsail_key_pair" "lg_key_pair" {
  name       = "importing"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}