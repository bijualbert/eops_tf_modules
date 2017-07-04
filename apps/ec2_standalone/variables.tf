variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}

variable "app_name" {
  description = "A value to append to the EC2 identifer to create a unique name"
  default = "ec2-instance"
}

variable "enabled" {
  default = 1
}

## Tags
variable "description" {
  default = "default description - you should have set this in your stack"
}
variable "environment" {
  default = "default environmetn - you should have set this in your stack"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {}
variable "tags_purpose" {
  default = ""
}

## Security group
variable "sg_name" {
  default = "default_security_group_name"
}

variable "sg_description" {
  default = "purpose of security group"
}