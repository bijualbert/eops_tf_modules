resource "aws_vpc_peering_connection_accepter" "vpc_peering_accepter" {
  provider = "aws.target_provider"
  depends_on = ["aws_vpc_peering_connection.vpc_peering"]

  vpc_peering_connection_id = "pcx-a3ddbdca"
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

resource "aws_route_table" "target_vpc_peer_route_table" {
  provider = "aws.target_provider"
  depends_on = ["aws_vpc_peering_connection.vpc_peering"]

  vpc_id = "${data.aws_vpc.target_vpc_main.id}"

  route {
    cidr_block = "${data.aws_vpc.source_vpc_main.cidr_block}"
    vpc_peering_connection_id = "pcx-a3ddbdca"
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