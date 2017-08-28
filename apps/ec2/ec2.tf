resource "aws_instance" "app" {
  ami = "${var.ami}"
  count = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.private == true ? false :true}"
  iam_instance_profile = "${data.asg_profile}"
  security_groups = ["${data.asg_security_group}"]
  subnet_id = "${element(module.aws_core_data.private_subnets,count.index)}"
  tags {
    Name            = "${var.app_name}${count.index + 1}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
    AutoOnOff       = "${var.tags_AutoOffOn}"
    AutoOn          = "${var.tags_AutoOn}"
    AutoOff         = "${var.tags_AutoOff}"
    AutoOnDays      = "${var.tags_AutoOnDays}"
  }
}