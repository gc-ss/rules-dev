data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_media_store_container" "example" {
  name = "example"
}

resource "aws_media_store_container_policy" "example" {
  container_name = "${aws_media_store_container.example.name}"

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
		"Sid": "MediaStoreFullAccess",
		"Action": [ "mediastore:*" ],
		"Principal": {"AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"},
		"Effect": "Allow",
		"Resource": "arn:aws:mediastore:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:container/${aws_media_store_container.example.name}/*",
		"Condition": {
			"Bool": { "aws:SecureTransport": "true" }
		}
	}]
}
EOF
}