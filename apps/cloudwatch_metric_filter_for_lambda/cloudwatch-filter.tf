resource "aws_cloudwatch_log_metric_filter" "lambda_memory_metric" {
  name = "lambda_memory_alarm"
  pattern = "${var.pattern}"
  log_group_name = "/aws/lambda/SumologicLambdaLogCollector"

  metric_transformation {
    name = "lambda_memory"
    namespace = "used_memory"
    value = "$MemUsed"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_memory_alert" {
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "lambda_memory_alarm"
  namespace                 = "AWS/Logs"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "120"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}