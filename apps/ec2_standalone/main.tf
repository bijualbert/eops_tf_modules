provider "aws" {
  region = "${var.region}"
}

module "aws_account_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data?ref=v0.2.1"
  // For local development use instead:
  //  source = "../../data_providers/aws_account_core_data"
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

# SG for ssh access
resource "aws_security_group" "security_group" {
  name = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id = "${module.aws_account_core_data.vpc_id}"
  tags {
    Name            = "${var.tags_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

//resource "aws_security_group_rule" "ingress_security_rule" {
//  security_group_id = "${aws_security_group.security_group.id}"
//  protocol = "${var.ingress_protocol}"
//  to_port = "${var.ingress_to_port}"
//  from_port = "${var.ingress_from_port}"
//  type = "ingress"
//}

//resource "aws_security_group_rule" "egress_security_rule" {
//  security_group_id = "${aws_security_group.security_group.id}"
//  protocol = "${var.egress_protocol}"
//  to_port = "${var.egress_to_port}"
//  from_port = "${var.egress_from_port}"
//  type = "egress"
//
//  tags {
//    Name            = "${var.tags_name}"
//    "Business Unit" = "${var.tags_business_unit}"
//    "Cost Center"   = "${var.tags_cost_center}"
//    Team            = "${var.tags_team}"
//    Purpose         = "${var.tags_purpose}"
//    Description     = "${var.description}"
//    Environment     = "${var.environment}"
//  }
//}

# instance
resource "aws_instance" "ec_instance" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.security_group.id}"]
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  user_data              = "${var.user_data}"
  associate_public_ip_address = "${var.associtate_public_id}"

  count = "${var.number_servers}"

  root_block_device {
    delete_on_termination = true
  }

  tags {
    Name            = "${var.application_name}-${count.index}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}
