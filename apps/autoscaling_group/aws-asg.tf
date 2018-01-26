resource "aws_launch_configuration" "app_lc" {
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  name_prefix                 = "${var.environment}-${var.app_name}-lc-"
  key_name                    = "${var.aws_key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.app_instance_profile.arn}"
  associate_public_ip_address = "${var.associate_public_ip}"
  user_data                   = "${var.user_data}"
  security_groups             = ["${concat(list(aws_security_group.asg_sg.id), var.security_groups)}"]

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "app_asg" {
  name                 = "${var.environment}-${var.app_name}-asg"
//  depends_on           = ["aws_launch_configuration.app_lc"]
  launch_configuration = "${aws_launch_configuration.app_lc.name}"
  desired_capacity = "${var.desired_nodes}"
  min_size             = "${var.desired_nodes}"
  max_size             = "${var.desired_nodes}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]

  lifecycle {
    create_before_destroy = true
  }

  tags = ["${var.asg_tags}"]
}