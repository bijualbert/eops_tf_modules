resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "${var.app_name}-ERROR Alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "0"
  alarm_description         = "This metric monitors messages on error queue"
  dimensions {
      QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
    }
}