

#---- 0 ----

resource "aws_worklink_fleet" "example" {
  name = "terraform-example"
}

resource "aws_worklink_website_certificate_authority_association" "test" {
  fleet_arn   = "${aws_worklink_fleet.test.arn}"
  certificate = "${file("certificate.pem")}"
}

#---- 1 ----

resource "aws_worklink_fleet" "example" {
  name = "terraform-example"
}

#---- 2 ----

resource "aws_worklink_fleet" "example" {
  name = "terraform-example"

  network {
    vpc_id             = "${aws_vpc.test.id}"
    subnet_ids         = ["${aws_subnet.test.*.id}"]
    security_group_ids = ["${aws_security_group.test.id}"]
  }
}

#---- 3 ----

resource "aws_worklink_fleet" "test" {
  name = "tf-worklink-fleet-%s"

  identity_provider {
    type          = "SAML"
    saml_metadata = "${file("saml-metadata.xml")}"
  }
}