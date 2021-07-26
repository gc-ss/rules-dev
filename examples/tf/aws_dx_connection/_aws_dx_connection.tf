

#---- 0 ----

resource "aws_dx_connection" "hoge" {
  name      = "tf-dx-connection"
  bandwidth = "1Gbps"
  location  = "EqDC2"
}

#---- 1 ----

resource "aws_dx_connection" "example" {
  name      = "example"
  bandwidth = "1Gbps"
  location  = "EqSe2"
}

resource "aws_dx_lag" "example" {
  name                  = "example"
  connections_bandwidth = "1Gbps"
  location              = "EqSe2"
}

resource "aws_dx_connection_association" "example" {
  connection_id = "${aws_dx_connection.example.id}"
  lag_id        = "${aws_dx_lag.example.id}"
}