output "asg_security_group_id" {
  value = "${aws_security_group.asg_sg.id}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.app_asg.id}"
}