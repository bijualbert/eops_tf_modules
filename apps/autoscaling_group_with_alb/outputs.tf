output "asg_security_group_id" {
  value = "${module.autoscaling_group.asg_security_group_id}"
}
output "alb_security_group_id" {
  value = "${aws_security_group.alb_sg.id}"
}

output "alb_arn" {
  value = "${aws_lb.asg_alb.arn}"
}

output "alb_dns" {
  value = "${aws_lb.asg_alb.dns_name}"
}

output "alb_name" {
  value = "${aws_lb.asg_alb.name}"
}

output "alb_zone_id" {
  value = "${aws_lb.asg_alb.zone_id}"
}
output "alb_tg_arn" {
  value = "${aws_lb_target_group.asg_alb_tg.arn}"
}

output "asg_id" {
  value = "${module.autoscaling_group.asg_id}"
}
