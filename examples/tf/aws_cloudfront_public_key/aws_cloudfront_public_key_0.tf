resource "aws_cloudfront_public_key" "example" {
  comment     = "test public key"
  encoded_key = "${file("public_key.pem")}"
  name        = "test_key"
}