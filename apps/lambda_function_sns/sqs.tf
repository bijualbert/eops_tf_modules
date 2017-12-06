resource "aws_sqs_queue" "lambda_error_queue" {
  name                      = "${var.app_name}-ERROR"
  message_retention_seconds = 1209600
}