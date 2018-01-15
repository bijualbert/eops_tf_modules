resource "aws_cloudwatch_event_rule" "app" {
  name                = "${var.app_name}"
  schedule_expression = "${var.schedule_expression}"
  count               = "${var.enabled}"
}

resource "aws_cloudwatch_event_target" "lambda_vpc" {
  target_id = "${var.app_name}"
  rule      = "${aws_cloudwatch_event_rule.app.name}"
  arn       = "${aws_lambda_function.app.arn}"
  count     = "${var.enabled}"
}

module "lambda_app_cloudwatch" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/cloudwatch_metric_filter_for_lambda?ref=WATSON-968-2"
  app_name = "${var.app_name}"
  log_group_name = "/aws/lambda/${var.app_name}"
  alarm_threshold = "${var.lambda_memory_alert_threshold}"
  alarm_action_arn = "${var.alarm_action_arn}"
}