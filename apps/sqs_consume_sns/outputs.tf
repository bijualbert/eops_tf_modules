output "sqs_queue_arn" {
  value = "${aws_sqs_queue.sqs_queue.arn}"
}

output "sqs_error_queue_arn" {
  value = "${aws_sqs_queue.sqs_error_queue.arn}"
}