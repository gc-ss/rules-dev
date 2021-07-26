resource "aws_opsworks_application" "foo-app" {
  name        = "foobar application"
  short_name  = "foobar"
  stack_id    = "${aws_opsworks_stack.main.id}"
  type        = "rails"
  description = "This is a Rails application"

  domains = [
    "example.com",
    "sub.example.com",
  ]

  environment {
    key    = "key"
    value  = "value"
    secure = false
  }

  app_source {
    type     = "git"
    revision = "master"
    url      = "https://github.com/example.git"
  }

  enable_ssl = true

  ssl_configuration {
    private_key = "${file("./foobar.key")}"
    certificate = "${file("./foobar.crt")}"
  }

  document_root         = "public"
  auto_bundle_on_deploy = true
  rails_env             = "staging"
}