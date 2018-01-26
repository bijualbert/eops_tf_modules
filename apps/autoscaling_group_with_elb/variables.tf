variable "ami_id" {}
variable "instance_type" {}
variable "environment" {}
variable "team_name" {}
variable "app_name" {}
variable "aws_key_name" {}
variable "domain" {}
variable "user_data" {}
variable "desired_nodes" {}
variable "vpc_id" {}

variable "asg_sg_ingress" {
  type = "list"
}

variable "elb_sg_ingress" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "elb_subnets" {
  type = "list"
}

variable "elb_listeners" {
  type = "list"
}

variable "asg_tags" {
  type = "list"
}

variable "asg_sg_tags" {
  type = "map"
}

variable "elb_sg_tags" {
  type ="map"
}

variable "security_groups" {
  type = "list"
  default = []
}

variable "elb_security_groups" {
  type = "list"
  default = []
}

variable "elb_tags" {
  type = "map"
}

variable "is_internal" {
  default = false
}

variable "healthy_threshold" {
  default = 2
}

variable "unhealthy_threshold" {
  default = 2
}

variable "timeout" {
  default = 3
}

variable "target" {
  default = "HTTP:80/"
}

variable "interval" {
  default = 10
}

variable "cross_zone_load_balancing" {
  default = true
}

variable "idle_timeout" {
  default = 300
}

variable "connection_draining" {
  default = true
}

variable "connection_draining_timeout" {
  default = 300
}