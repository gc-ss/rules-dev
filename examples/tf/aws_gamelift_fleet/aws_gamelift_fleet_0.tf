resource "aws_gamelift_fleet" "example" {
  build_id          = "${aws_gamelift_build.example.id}"
  ec2_instance_type = "t2.micro"
  fleet_type        = "ON_DEMAND"
  name              = "example-fleet-name"

  runtime_configuration {
    server_process {
      concurrent_executions = 1
      launch_path           = "C:\\game\\GomokuServer.exe"
    }
  }
}