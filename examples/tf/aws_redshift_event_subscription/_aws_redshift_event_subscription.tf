

#---- 0 ----

resource "aws_redshift_cluster" "default" {
  cluster_identifier = "default"
  database_name      = "default"

  # ...
}

resource "aws_sns_topic" "default" {
  name = "redshift-events"
}

resource "aws_redshift_event_subscription" "default" {
  name          = "redshift-event-sub"
  sns_topic_arn = "${aws_sns_topic.default.arn}"

  source_type = "cluster"
  source_ids  = ["${aws_redshift_cluster.default.id}"]

  severity = "INFO"

  event_categories = [
    "configuration",
    "management",
    "monitoring",
    "security",
  ]

  tags = {
    Name = "default"
  }
}