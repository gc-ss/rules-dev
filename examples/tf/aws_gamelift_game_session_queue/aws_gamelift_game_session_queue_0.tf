resource "aws_gamelift_game_session_queue" "test" {
  name = "example-session-queue"

  destinations = [
    "${aws_gamelift_fleet.us_west_2_fleet.arn}",
    "${aws_gamelift_fleet.eu_central_1_fleet.arn}",
  ]

  player_latency_policy {
    maximum_individual_player_latency_milliseconds = 100
    policy_duration_seconds                        = 5
  }

  player_latency_policy {
    maximum_individual_player_latency_milliseconds = 200
  }

  timeout_in_seconds = 60
}