resource "aws_sns_topic" "lambda_replay_sns" {
  name = "${var.app_name}-REPLAY"
}

resource "aws_sns_topic_subscription" "lambda_replay_topic_subscription" {
  topic_arn = "${aws_sns_topic.lambda_replay_sns.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.app.arn}"
}

resource "aws_lambda_permission" "allow_sns_replay" {
  statement_id   = "AllowExecutionFromSNS"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.app.function_name}"
  principal      = "sns.amazonaws.com"  
  source_arn     = "${aws_sns_topic.lambda_replay_sns.arn}"  
}

resource "aws_sns_topic_subscription" "lambda_event_topic_subscription" {
  topic_arn = "${var.lambda_sns_subscription_arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.app.arn}"
}

resource "aws_lambda_permission" "allow_sns_event" {
  statement_id   = "AllowExecutionFromSNS"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.app.function_name}"
  principal      = "sns.amazonaws.com"  
  source_arn     = "${var.lambda_sns_subscription_arn}"
}