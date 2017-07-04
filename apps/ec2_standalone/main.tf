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
  name        = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id      = "${module.aws_account_core_data.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ams_office}"]
  }

  ingress {
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["${module.aws_account_core_data.vpc_cidr}"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name            = "${var.key_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

# instance
resource "aws_instance" "ec_instance" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.security_group.id}"]
  subnet_id              = "${module.aws_account_core_data.private_subnets[0]}"
  key_name               = "${var.key_name}"
  user_data              = "${var.user_data}"
  associate_public_ip_address = true

  count = "${var.number_servers}"

  tags {
    Name            = "${module.aws_account_core_data.account_id}-${var.application_name}-${count.index}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}
