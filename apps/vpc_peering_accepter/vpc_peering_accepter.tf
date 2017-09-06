resource "aws_vpc_peering_connection_accepter" "vpc_peering_accepter" {
    provider                  = "aws.peer"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
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