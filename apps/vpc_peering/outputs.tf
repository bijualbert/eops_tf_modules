output "ecom1_vpc_id" {
  value = "${data.aws_vpc.ecom1_vpc_main.id}"
}
output "db_vpc_id" {
  value = "${data.aws_vpc.db_vpc_main.id}"
}