resource "aws_organizations_organizational_unit" "example" {
  name      = "example"
  parent_id = "${aws_organizations_organization.example.roots.0.id}"
}