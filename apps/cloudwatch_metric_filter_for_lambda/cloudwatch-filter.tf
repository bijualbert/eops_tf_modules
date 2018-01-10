resource "aws_cloudwatch_log_metric_filter" "lambda_memory_alarm" {
  name = "lambda_memory_alarm"
  pattern = "${var.pattern}"
  log_group_name = "/aws/lambda/SumologicLambdaLogCollector"

  metric_transformation {
    name = "lambda_memory"
    namespace = "used_memory"
    value = "$MemUsed"
  }
}
