output "elb_dns_name" {
  value = "${aws_elb.load_balancer.dns_name}"
}

output "instance_ids" {
  value = ["${aws_instance.app.*.id}"]
}
