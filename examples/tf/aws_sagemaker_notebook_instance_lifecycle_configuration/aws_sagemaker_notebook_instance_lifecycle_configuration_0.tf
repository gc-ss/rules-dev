resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lc" {
  name      = "foo"
  on_create = base64encode("echo foo")
  on_start  = base64encode("echo bar")
}