resource "aws_organizations_policy_attachment" "unit" {
  policy_id = "${aws_organizations_policy.example.id}"
  target_id = "${aws_organizations_organizational_unit.example.id}"
}