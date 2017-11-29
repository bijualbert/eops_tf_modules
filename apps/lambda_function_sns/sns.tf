resource "aws_sns_topic" "lambda_replay_sns" {
  name = "${var.app_name}-REPLAY"
}

resource "aws_sns_topic_subscription" "lambda_replay_topic_subscription" {
  topic_arn = "${aws_sns_topic.lambda_replay_sns.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.app.arn}"
}