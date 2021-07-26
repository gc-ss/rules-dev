

#---- 0 ----

resource "aws_sns_topic" "aws_sns_topic" {
  name = "glacier-sns-topic"
}

resource "aws_glacier_vault" "my_archive" {
  name = "MyArchive"

  notification {
    sns_topic = "${aws_sns_topic.aws_sns_topic.arn}"
    events    = ["ArchiveRetrievalCompleted", "InventoryRetrievalCompleted"]
  }

  access_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
       {
          "Sid": "add-read-only-perm",
          "Principal": "*",
          "Effect": "Allow",
          "Action": [
             "glacier:InitiateJob",
             "glacier:GetJobOutput"
          ],
          "Resource": "arn:aws:glacier:eu-west-1:432981146916:vaults/MyArchive"
       }
    ]
}
EOF

  tags = {
    Test = "MyArchive"
  }
}

#---- 1 ----

resource "aws_glacier_vault" "example" {
  name = "example"
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["glacier:DeleteArchive"]
    effect    = "Deny"
    resources = ["${aws_glacier_vault.example.arn}"]

    condition {
      test     = "NumericLessThanEquals"
      variable = "glacier:ArchiveAgeinDays"
      values   = ["365"]
    }
  }
}

resource "aws_glacier_vault_lock" "example" {
  complete_lock = false
  policy        = "${data.aws_iam_policy_document.example.json}"
  vault_name    = "${aws_glacier_vault.example.name}"
}