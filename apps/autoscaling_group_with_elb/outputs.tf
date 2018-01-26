output "asg_security_group_id" {
  value = "${module.autoscaling_group.asg_security_group_id}"
}
output "elb_security_group_id" {
  value = "${aws_security_group.elb_sg.id}"
}

output "elb_arn" {
  value = "${aws_elb.asg_elb.arn}"
}

output "elb_dns" {
  value = "${aws_elb.asg_elb.dns_name}"
}

output "elb_name" {
  value = "${aws_elb.asg_elb.name}"
}

output "elb_zone_id" {
  value = "${aws_elb.asg_elb.zone_id}"
}