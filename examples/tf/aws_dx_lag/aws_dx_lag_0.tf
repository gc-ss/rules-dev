resource "aws_dx_lag" "hoge" {
  name                  = "tf-dx-lag"
  connections_bandwidth = "1Gbps"
  location              = "EqDC2"
  force_destroy         = true
}