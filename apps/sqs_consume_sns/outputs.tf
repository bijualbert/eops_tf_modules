output "sqs_queue_arn" {
  value = "${aws_sqs_queue.sqs_queue.arn}"
}
output "sqs_queue_id" {
  value = "${aws_sqs_queue.sqs_queue.id}"
}


output "sqs_error_queue_arn" {
  value = "${aws_sqs_queue.sqs_error_queue.arn}"
}
output "sqs_error_queue_id" {
  value = "${aws_sqs_queue.sqs_error_queue.id}"
}

output "replay_sns_arn" {
  value = "${aws_sns_topic.replay_sns.arn}"
}