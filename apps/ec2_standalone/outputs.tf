output "instance_ids" {
  value = ["${aws_instance.ec_instance.*.id}"]
}