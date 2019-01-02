resource "aws_lb" "asg_alb" {
  name               = "${var.environment}-${var.app_name}-${var.domain}-alb"
  internal = "${var.is_internal}"
  load_balancer_type = "application"
  security_groups = ["${concat(list(aws_security_group.alb_sg.id), var.alb_security_groups)}"]
  subnets = ["${var.alb_subnets}"]

  enable_deletion_protection = true

  tags = "${var.alb_tags}"
}

resource "aws_lb_target_group" "asg_alb_tg" {
  name     = "${var.environment}-${var.app_name}-tg"
  port     = "${var.tg_port}"
  protocol = "${var.tg_protocol}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    path              = "${var.health_check_path}"
    interval            = "${var.interval}"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-${var.app_name}-${var.domain}-alb-sg"
  vpc_id = "${var.vpc_id}"

  ingress = ["${var.alb_sg_ingress}"]

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.alb_sg_tags}"
}

resource "aws_autoscaling_attachment" "asg_attachment_alb" {
  autoscaling_group_name = "${module.autoscaling_group.asg_id}"
  alb_target_group_arn   = "${aws_lb_target_group.asg_alb_tg.arn}"
}