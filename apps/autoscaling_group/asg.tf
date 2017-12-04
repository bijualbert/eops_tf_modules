# AWS Auto Scaling Group

## Creates auto scaling group
resource "aws_autoscaling_group" "asg" {
  launch_configuration      = "${aws_launch_configuration.launch_config.id}"
  default_cooldown          = "${length(var.default_cooldown) > 0 ? var.default_cooldown : "300"}"
  desired_capacity          = "${length(var.desired_capacity) > 0 ? var.desired_capacity : var.min_size}"
  health_check_grace_period = "${length(var.hc_grace_period) > 0 ? var.hc_grace_period : "300"}"
  health_check_type         = "EC2"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  name                      = "${var.app_name}"
  availability_zones  = ["eu-west-1b", "eu-west-1a"]

  tag {
    key                 = "Name"
    value               = "${var.app_name}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Business Unit"
    value               = "${var.tags_business_unit}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Cost Center"
    value               = "${var.tags_cost_center}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Team"
    value               = "${var.tags_team}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Purpose"
    value               = "${var.tags_purpose}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Description"
    value               = "${var.description}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key                 = "AutoOffOn"
    value               = "${var.tags_AutoOffOn}"
    propagate_at_launch = true
  }
  tag {
    key                 = "AutoOn"
    value               = "${var.tags_AutoOn}"
    propagate_at_launch = true
  }
  tag {
    key                 = "AutoOff"
    value               = "${var.tags_AutoOff}"
    propagate_at_launch = true
  }
  tag {
    key                 = "AutoOnDays"
    value               = "${var.tags_AutoOnDays}"
    propagate_at_launch = true
  }

}

resource "aws_launch_configuration" "launch_config" {
  name          = "${var.app_name}"
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
}

# SG for instance
resource "aws_security_group" "asg" {
  name        = "SG-${var.app_name}"
  description = "Allow inbound traffic for ${var.app_name}"
  vpc_id      = "${module.aws_core_data.vpc_id}"
  tags {
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

resource "aws_iam_instance_profile" "asg" {
  name = "${var.app_name}-asg"
  roles = ["${aws_iam_role.asg.id}"]
  //  role = "${aws_iam_role.asg.id}"
}

resource "aws_iam_role" "asg" {
  name = "${var.app_name}-asg"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}