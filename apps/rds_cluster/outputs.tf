output "rds_ids" {
  description = "rds db instace(s) id(s)"
  value       = "${aws_db_instance.db_instance.*.id}"
}

output "rds_arns" {
  description = "rds db instace(s) arn(s)"
  value       = "${aws_db_instance.db_instance.*.arn}"
}

output "rds_addresses" {
  description = "rds db instace(s) address(es)"
  value       = "${aws_db_instance.db_instance.*.address}"
}

output "endpoints" {
  description = "rds cluster endpoint"
  value       = "${aws_rds_cluster.rds_cluster.*.endpoint}"
}

output "reader_endpoints" {
  description = "rds cluster reader endpoint"
  value       = "${aws_rds_cluster.rds_cluster.*.reader_endpoint}"
}

output "aws_db_subnet_group_ids" {
  description = "rds subnet group id(s)"
  value       = "${aws_db_subnet_group.db_subnet_group.id}"
}

output "db_parameter_groups" {
  description = "rds db parameter group id(s)"
  value       = "${aws_db_parameter_group.db_parameter_group.*.id}"
}

output "hosted_zone_ids" {
  description = "rds db  instace(s) hosted zone id(s)"
  value       = "${aws_db_instance.db_instance.*.hosted_zone_id}"
}

output "db_admin_username" {
  description = "rds cluster admin user name"
  value       = "${var.db_username}"
}

output "db_admin_password" {
  description = "rds cluster admin user password"
  sensitive   = true
  value       = "${local.master_password}"
}

output "rds_db_identifier" {
  description = "rds instance / cluster identifier"
  sensitive = true
  value =  "${lower(var.name)}-rds-${lower(var.environment)}"
}

output "rds_port" {
  description = "rds port"
  value = "${lookup(var.default_ports, var.engine)}"
}

output "sg_allow_db_access_id" {
  description  = "security group id to allow db access"
  value = "${aws_security_group.allow_db_access.id}"
}

output "serverless_endpoints" {
  description = "serverless cluster endpoint"
  value       = "${aws_rds_cluster.serverless_cluster.*.endpoint}"
}

output "serverless_reader_endpoints" {
  description = "serverless cluster reader endpoint"
  value       = "${aws_rds_cluster.serverless_cluster.*.reader_endpoint}"
}
