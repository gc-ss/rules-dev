resource "aws_placement_group" "web" {
  name     = "hunky-dory-pg"
  strategy = "cluster"
}