provider "aws" {
  region = "eu-west-1"
  //  profile = "db-sandbox"
  alias = "db-sb"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.db_sb_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "db_vpc_id" {
  provider = "aws.db-sb"
  tags {
    Name = "main"
  }
}

resource "aws_vpc_peering_connection" "vpc_peering" {
    peer_vpc_id   = "${data.aws_vpc.ecom1_vpc_id.id}"
    vpc_id        = "${data.aws_vpc.db_vpc_id.id}"

    accepter {
      allow_remote_vpc_dns_resolution = true
    }

    requester {
      allow_remote_vpc_dns_resolution = true
    }
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