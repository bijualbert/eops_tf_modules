resource "aws_cloudwatch_metric_alarm" "sqs_error_queue_alarm" {
  alarm_name                = "${var.app_name}-ERROR-QUEUE-ALARM"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "0"
  alarm_description         = "This alarm monitors messages on error queue"
  alarm_actions             = ["${var.sns_alert_arn}"]
  count                     = "${var.environment == "test" ? 1 : 0 }"
  dimensions {
      QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
    }
}