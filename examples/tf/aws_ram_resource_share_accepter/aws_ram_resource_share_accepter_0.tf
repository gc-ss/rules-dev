provider "aws" {
  profile = "profile2"
}

provider "aws" {
  alias   = "alternate"
  profile = "profile1"
}

resource "aws_ram_resource_share" "sender_share" {
  provider = "aws.alternate"

  name                      = "tf-test-resource-share"
  allow_external_principals = true

  tags = {
    Name = "tf-test-resource-share"
  }
}

resource "aws_ram_principal_association" "sender_invite" {
  provider = "aws.alternate"

  principal          = "${data.aws_caller_identity.receiver.account_id}"
  resource_share_arn = "${aws_ram_resource_share.sender_share.arn}"
}

data "aws_caller_identity" "receiver" {}

resource "aws_ram_resource_share_accepter" "receiver_accept" {
  share_arn = "${aws_ram_principal_association.sender_invite.resource_share_arn}"
}