resource "aws_batch_job_queue" "test_queue" {
  name                 = "tf-test-batch-job-queue"
  state                = "ENABLED"
  priority             = 1
  compute_environments = ["${aws_batch_compute_environment.test_environment_1.arn}", "${aws_batch_compute_environment.test_environment_2.arn}"]
}