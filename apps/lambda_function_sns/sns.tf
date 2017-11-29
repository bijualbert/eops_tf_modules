resource "aws_sns_topic" "lambda_replay_sns" {
  name = "${var.app_name}_REPLAY"
}