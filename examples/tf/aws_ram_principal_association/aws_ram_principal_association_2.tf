resource "aws_ram_principal_association" "example" {
  principal          = "${aws_organizations_organization.example.arn}"
  resource_share_arn = "${aws_ram_resource_share.example.arn}"
}