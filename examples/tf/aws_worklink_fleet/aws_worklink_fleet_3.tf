resource "aws_worklink_fleet" "test" {
  name = "tf-worklink-fleet-%s"

  identity_provider {
    type          = "SAML"
    saml_metadata = "${file("saml-metadata.xml")}"
  }
}