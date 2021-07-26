resource "aws_codebuild_webhook" "example" {
  project_name = "${aws_codebuild_project.example.name}"

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "master"
    }
  }
}