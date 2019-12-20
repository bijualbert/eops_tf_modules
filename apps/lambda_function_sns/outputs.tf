output "security_group_id" {
  value = "${aws_security_group.sg_for_app.id}"
}
output "lambda_kms_key_id" {
  value = "${aws_lambda_function.app.*.id}"
}
output "lambda_arn" {
  value = "${aws_lambda_function.app.*.arn}"
}
output "function_name" {
  value = "${aws_lambda_function.app.function_name}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.iam_for_app.*.arn}"
}