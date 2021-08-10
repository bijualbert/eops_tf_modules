
#ERROR QUEUE
resource "aws_sqs_queue" "sqs_error_queue" {
  name                        = "${var.app_name}-ERROR"
  message_retention_seconds   = 1209600
  tags                        = "${local.tags}"
}