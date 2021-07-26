resource "aws_codecommit_repository" "test" {
  repository_name = "test"
}

resource "aws_codecommit_trigger" "test" {
  repository_name = "${aws_codecommit_repository.test.repository_name}"

  trigger {
    name            = "all"
    events          = ["all"]
    destination_arn = "${aws_sns_topic.test.arn}"
  }
}