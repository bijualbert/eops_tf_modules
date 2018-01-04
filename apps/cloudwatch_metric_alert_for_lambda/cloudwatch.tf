//# setup for Sumo
//resource "aws_cloudwatch_log_subscription_filter" "lambdafunction_logfilter" {
//  name            = "sumo_lambdafunction_logfilter"
//  role_arn        = "${var.cloudwatch_subscription_role_arn}"
//  log_group_name  = "/aws/lambda/example_lambda_name"
//  filter_pattern  = "logtype test"
//  destination_arn = "${var.cloudwatch_subscription_arn}"
//}

# Setup Cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "lambda_invocations_alarm" {
  alarm_name                = "${var.app_name}-invocation"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Invocations"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "180"
  alarm_description         = "This metric monitors lambda invocations"
  insufficient_data_actions = []
  dimensions {
    FunctionName = "${var.app_name}"
  }
  ok_actions = ["arn:aws:sns:eu-west-1:047710374887:ERROR-AlertQueue"]
  alarm_actions = ["arn:aws:sns:eu-west-1:047710374887:ERROR-AlertQueue"]
  insufficient_data_actions = ["arn:aws:sns:eu-west-1:047710374887:ERROR-AlertQueue"]
}

resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name                = "${var.app_name}-error"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Invocations"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "180"
  alarm_description         = "This metric monitors lambda invocations"
  insufficient_data_actions = []
  dimensions {
    FunctionName = "${var.app_name}"
  }
  ok_actions = ["arn:aws:sns:eu-west-1:047710374887:ERROR-AlertQueue"]
  alarm_actions = ["arn:aws:sns:eu-west-1:047710374887:ERROR-AlertQueue"]
  insufficient_data_actions = ["arn:aws:sns:eu-west-1:047710374887:ERROR-AlertQueue"]
}