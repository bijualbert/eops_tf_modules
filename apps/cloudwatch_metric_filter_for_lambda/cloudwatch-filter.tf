resource "aws_cloudwatch_log_metric_filter" "lambda_memory_metric" {
  name = "${var.app_name}_memory_metric_filter"
  pattern = "${var.pattern}"
  log_group_name = "${var.log_group_name}"

  metric_transformation {
    name = "lambda_memory"
    value = "$MemUsed"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_memory_alert" {
  alarm_name                = "${var.app_name}_memory_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  datapoints_to_alarm       = "1"
  metric_name               = "lambda_memory"
  namespace                 = "AWS/Logs"
  period                    = "${var.period}"
  statistic                 = "Maximum"
  threshold                 = "${var.alarm_threshold}"
  alarm_description         = "This metric alerts on memory usage"
  insufficient_data_actions = []
  alarm_actions = ["${var.alarm_action_arn}"]
  actions_enabled = "${var.action_enabled}"
}