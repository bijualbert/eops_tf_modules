output "instance_ids" {
  value = ["${aws_instance.ec_instance.*.id}"]
}

output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}