# Outputs
output "asg_security_group" {
  value = "${aws_security_group.asg.id}"
}

output "asg_profile"{
  value = "${aws_iam_instance_profile.asg.id}"
}

output "asg_iam_role" {
  value = "${aws_iam_role.asg.id}"
}