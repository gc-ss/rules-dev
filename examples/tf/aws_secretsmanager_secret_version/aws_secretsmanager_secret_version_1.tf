# The map here can come from other supported configurations
# like locals, resource attribute, map() built-in, etc.
variable "example" {
  default = {
    key1 = "value1"
    key2 = "value2"
  }

  type = "map"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = "${aws_secretsmanager_secret.example.id}"
  secret_string = "${jsonencode(var.example)}"
}