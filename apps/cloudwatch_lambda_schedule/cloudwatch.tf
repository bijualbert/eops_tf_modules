resource "aws_cloudwatch_event_rule" "app" {
  name                = "${var.app_name}"
  schedule_expression = "${var.schedule_expression}"
  count               = "${var.enabled}"
}

resource "aws_cloudwatch_event_target" "lambda_vpc" {
  target_id = "${var.app_name}"
  rule      = "${aws_cloudwatch_event_rule.app.name}"
  arn       = "${var.lambda_arn}"
  count     = "${var.enabled}"
}