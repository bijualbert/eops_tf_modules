resource "aws_vpc_peering_connection_accepter" "vpc_peering_accepter" {
  provider = "aws.ecom1-sb"

  vpc_peering_connection_id = "${data.aws_vpc.db_vpc_main.id}"
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