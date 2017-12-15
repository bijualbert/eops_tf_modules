output "security_group_id" {
  value = "${aws_security_group.sg_for_app.id}"
}
output "iam_role_arn" {
  value = "${aws_iam_role.iam_for_app.arn}"
}