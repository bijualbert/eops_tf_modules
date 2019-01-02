//provider "aws" {
//}

module "autoscaling_group" {
  source = "../../apps/autoscaling_group"
  ami_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  environment = "${var.environment}"
  app_name = "${var.app_name}"
  aws_key_name = "${var.aws_key_name}"
  domain = "${var.domain}"
  user_data = "${var.user_data}"
  security_groups = ["${var.security_groups}"]
  desired_nodes = "${var.desired_nodes}"
  subnet_ids = ["${var.subnet_ids}"]
  asg_tags = ["${var.asg_tags}"]
  vpc_id = "${var.vpc_id}"
  asg_sg_ingress = ["${var.asg_sg_ingress}"]
  team_name = "${var.team_name}"
  asg_sg_tags = "${var.asg_sg_tags}"
  associate_public_ip = "${var.associate_public_ip}"
  role_policy = "${var.role_policy}"
  role_policy_description = "${var.role_policy_description}"
  providers = {
   aws = "aws"
  } 
}