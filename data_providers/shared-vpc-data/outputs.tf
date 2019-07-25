output "vpc_id" {
  value = "${data.aws_vpc.working_vpc.id}"
}

output "all_subnet_ids" {
  value = ["${data.aws_subnet_ids.all.ids}"]
}

output "public_subnet_ids" {
  value = ["${data.aws_subnet_ids.public.ids}"]
}

output "private_subnet_ids" {
  value = ["${data.aws_subnet_ids.private.ids}"]
}
