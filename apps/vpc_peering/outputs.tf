output "target_vpc_id" {
  value = "${data.aws_vpc.target_vpc_main.id}"
}

output "source_vpc_id" {
  value = "${data.aws_vpc.source_vpc_main.id}"
}

//output "accept_state_target" {
//  value = "${data.terraform_remote_state.terraform-ap.?}"
//}
