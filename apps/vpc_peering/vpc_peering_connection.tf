resource "aws_vpc_peering_connection" "vpc_peering" {
    peer_owner_id = "${var.peer_owner_id}"
    peer_vpc_id   = "${var.source_vpc_id}"
    vpc_id        = "${var.target_vpc_id}"

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