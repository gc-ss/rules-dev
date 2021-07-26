resource "aws_appautoscaling_target" "dynamodb" {
  max_capacity       = 100
  min_capacity       = 5
  resource_id        = "table/tableName"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_scheduled_action" "dynamodb" {
  name               = "dynamodb"
  service_namespace  = "${aws_appautoscaling_target.dynamodb.service_namespace}"
  resource_id        = "${aws_appautoscaling_target.dynamodb.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb.scalable_dimension}"
  schedule           = "at(2006-01-02T15:04:05)"

  scalable_target_action {
    min_capacity = 1
    max_capacity = 200
  }
}