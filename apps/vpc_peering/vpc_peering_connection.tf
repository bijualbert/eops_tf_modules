resource "aws_vpc_peering_connection" "vpc_peering" {
  provider = "aws.source_provider"

  peer_vpc_id   = "${data.aws_vpc.target_vpc_main.id}"
  vpc_id        = "${data.aws_vpc.source_vpc_main.id}"

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

resource "aws_route_table" "source_vpc_peer_route_table" {
  provider = "aws.source_provider"

  vpc_id = "${data.aws_vpc.source_vpc_main.id}"

  route {
    cidr_block = "${data.aws_vpc.target_vpc_main.cidr_block}"
    vpc_peering_connection_id = "${peer_connection_id}"
  }

  tags {
    Name            = "${var.app_name}-route"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

