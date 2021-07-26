resource "aws_organizations_policy_attachment" "root" {
  policy_id = "${aws_organizations_policy.example.id}"
  target_id = "${aws_organizations_organization.example.roots.0.id}"
}