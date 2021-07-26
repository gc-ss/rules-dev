resource "aws_datasync_location_nfs" "example" {
  server_hostname = "nfs.example.com"
  subdirectory    = "/exported/path"

  on_prem_config {
    agent_arns = ["${aws_datasync_agent.example.arn}"]
  }
}