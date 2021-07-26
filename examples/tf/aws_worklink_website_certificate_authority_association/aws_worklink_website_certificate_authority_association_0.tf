resource "aws_worklink_fleet" "example" {
  name = "terraform-example"
}

resource "aws_worklink_website_certificate_authority_association" "test" {
  fleet_arn   = "${aws_worklink_fleet.test.arn}"
  certificate = "${file("certificate.pem")}"
}