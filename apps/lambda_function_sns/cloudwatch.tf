module "lambda_app_cloudwatch" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/cloudwatch_metric_filter_for_lambda?ref=WATSON-968"
  app_name = "${var.app_name}"
  log_group_name = "/aws/lambda/${var.app_name}"
  alarm_threshold = "${var.lambda_memory_alert_threshold}"
  alarm_action_arn = "${var.alarm_action_arn}"
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "/aws/lambda/${var.app_name}"
  retention_in_days = "${var.retention_days}"

  tags {
    Environment = "${var.environment}"
  }
}