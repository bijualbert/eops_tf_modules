output "lambda_arn" {
  value = "${aws_lambda_function.app.*.arn}"
}

output "sqs_queue_arn" {
  value = "${aws_sqs_queue.sqs_queue.arn}"
}
output "sqs_queue_url" {
  value = "${aws_sqs_queue.sqs_queue.id}"
}

output "lambda_security_group" {
  description = "SG id created for the lambda"
  value = "${aws_security_group.sg_for_app.id}"
}
