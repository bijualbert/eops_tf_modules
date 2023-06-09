module "lambda_app_cloudwatch" {
  source                   = "../../apps/cloudwatch_lambda"
  app_name                 = "${var.app_name}"
  log_group_name           = "/aws/lambda/${var.app_name}"
  alarm_threshold          = "${var.lambda_memory_alert_threshold}"
  alarm_timeout            = "${var.timeout}"
  alarm_action_arn         = "${var.alarm_action_arn}"
  environment              = "${var.environment}"
  tags_team                = "${var.tags_team}"
  tags_domain              = "${var.tags_domain}"
  tags_purpose             = "${var.tags_purpose}"
  tags_cost_center         = "${var.tags_cost_center}"
  description              = "${var.description}"
  retention_days           = "${var.retention_days}"
  enable_cloudwatch_alarms = "${var.enable_cloudwatch_alarms}"
  enable_cloudwatch_error_alarm = 0
  providers = {
    aws = "aws"
  }
}