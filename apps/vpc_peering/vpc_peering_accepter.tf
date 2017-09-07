provider "aws" {
  region = "eu-west-1"
  //  profile = "ecom1-sandbox"
  alias = "ecom1-sb"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.ecom1_sb_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "ecom1_vpc_id" {
  provider = "aws.ecom1-sb"
  tags {
    Name = "main"
  }
}

resource "aws_vpc_peering_connection_accepter" "vpc_peering_accepter" {
  provider = "aws.ecom1-sb"

  vpc_peering_connection_id = "${data.aws_vpc.db_vpc_id.id}"
  auto_accept               = true

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