

#---- 0 ----

resource "aws_sagemaker_model" "m" {
  name               = "my-model"
  execution_role_arn = "${aws_iam_role.foo.arn}"

  primary_container {
    image = "174872318107.dkr.ecr.us-west-2.amazonaws.com/kmeans:1"
  }
}

resource "aws_iam_role" "r" {
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}