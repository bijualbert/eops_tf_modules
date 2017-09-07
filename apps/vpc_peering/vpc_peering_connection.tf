resource "aws_vpc_peering_connection" "vpc_peering" {
  provider = "aws.db-sb"

  peer_vpc_id   = "${data.aws_vpc.ecom1_vpc_main.id}"
  vpc_id        = "${data.aws_vpc.db_vpc_main.id}"

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

resource "aws_route_table" "db_vpc_route_table" {
  vpc_id = "${data.aws_vpc.db_vpc_main.id}"

  route {
    cidr_block = "${data.aws_vpc.ecom1_vpc_main.cidr_block}"
  }
}