resource "aws_cloudwatch_metric_alarm" "the_alarm" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM-1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "900"  // 15 minutes
  statistic                 = "Maximum"
  threshold                 = "3600" // 1 hour
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.sns_alert_arn}"]
  count                     = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "the_alarm" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM-2"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "10800" // 3 hours
  statistic                 = "Maximum"
  threshold                 = "86400" // 1 day
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.sns_alert_arn}"]
  count                     = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "the_alarm" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM-3"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "86400"  // 1 day
  statistic                 = "Maximum"
  threshold                 = "259200" // 3 days
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.sns_alert_arn}"]
  count                     = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
}