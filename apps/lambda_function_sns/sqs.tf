resource "aws_sqs_queue" "lambda_error_queue" {
  name                      = "${var.app_name}-ERROR"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 1209600
  receive_wait_time_seconds = 10  
}