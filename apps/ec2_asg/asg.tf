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
//  roles                     = ["${aws_iam_role.asg.id}"]

  //  count = "${length(var.min_elb_capacity) > 0 || length(var.wait_for_elb_capacity) > 0 ? 0 : 1}"
  //  metrics_granularity       = "${var.metrics_granularity}"
  //  placement_group           = "${var.placement_group}"
  //  protect_from_scale_in     = "${var.protect_from_scale_in}"
  //  suspended_processes       = ["${compact(var.suspended_processes)}"]
  //  target_group_arns         = ["${compact(var.target_group_arns)}"]
  //  termination_policies      = ["${compact(var.termination_policies)}"]
  //  vpc_zone_identifier       = ["${compact(var.subnets)}"]
  //  wait_for_capacity_timeout = "${length(var.wait_for_capacity_timeout) > 0 ? var.wait_for_capacity_timeout : "10m"}"
  //enabled_metrics           = ["${compact(var.enabled_metrics)}"]
  //force_delete              = "${var.force_delete}"

//  tags {
//    Name            = "${var.app_name}"
//    "Business Unit" = "${var.tags_business_unit}"
//    "Cost Center"   = "${var.tags_cost_center}"
//    Team            = "${var.tags_team}"
//    Purpose         = "${var.tags_purpose}"
//    Description     = "${var.description}"
//    Environment     = "${var.environment}"
//    AutoOnOff       = "${var.tags_AutoOffOn}"
//    AutoOn          = "${var.tags_AutoOn}"
//    AutoOff         = "${var.tags_AutoOff}"
//    AutoOnDays      = "${var.tags_AutoOnDays}"
//  }
}

resource "aws_launch_configuration" "launch_config" {
  name          = "autoOnOff_test_launch_config"
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
}
