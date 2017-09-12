output "target_vpc_id" {
  value = "${data.aws_vpc.target_vpc_main.id}"
}

output "source_vpc_id" {
  value = "${data.aws_vpc.source_vpc_main.id}"
}

output "peer_connection_id" {
  value = "${aws_vpc_peering_connection.vpc_peering.id}"
}