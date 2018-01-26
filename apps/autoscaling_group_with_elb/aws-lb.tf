//locals {
//  default_instance_port = "${var.lb_port}"
//  instance_port         = "${var.instance_port != "" ? var.instance_port : local.default_instance_port}"
//}
//
//locals {
//  default_instance_protocol = "${var.lb_protocol}"
//  instance_protocol         = "${var.instance_protocol != "" ? var.instance_protocol : local.default_instance_protocol}"
//}

resource "aws_elb" "asg_elb" {
  name = "${var.environment}-${var.app_name}-${var.domain}-elb"
  subnets = ["${var.elb_subnets}"]
  internal = "${var.is_internal}"
  security_groups = ["${concat(list(aws_security_group.elb_sg.id), var.elb_security_groups)}"]

  listener = ["${var.elb_listeners}"]

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    target              = "${var.target}"
    interval            = "${var.interval}"
  }

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  tags = "${var.elb_tags}"
}

resource "aws_security_group" "elb_sg" {
  name        = "${var.environment}-${var.app_name}-${var.domain}-elb-sg"
  vpc_id = "${var.vpc_id}"

  ingress = ["${var.elb_sg_ingress}"]

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.elb_sg_tags}"
}

resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = "${module.autoscaling_group.asg_id}"
  elb                    = "${aws_elb.asg_elb.id}"
}