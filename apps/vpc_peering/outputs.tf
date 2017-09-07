output "ecom1_vpc_id" {
  value = "${data.aws_vpc.ecom1_vpc_id.id}"
}
output "db_vpc_id" {
  value = "${data.aws_vpc.db_vpc_id.id}"
}