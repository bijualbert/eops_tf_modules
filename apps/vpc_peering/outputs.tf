output "ecom1_vpc_id" {
  value = "${data.aws_vpc.ecom1_vpc_main.id}"
}

//output "ecom1_vpc_route_table" {
//  value = "${data.aws_route_table.ecom1_vpc_route_table.id}"
//}

output "db_vpc_id" {
  value = "${data.aws_vpc.db_vpc_main.id}"
}

//output "db_vpc_route_table" {
//  value = "${data.aws_route_table.db_vpc_route_table.id}"
//}

output "peer_connection_id" {
  value = "${aws_vpc_peering_connection.vpc_peering.id}"
}
