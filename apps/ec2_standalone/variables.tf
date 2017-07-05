variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}

variable "ams_office" {
  default = "77.60.83.148/32"
}

variable "app_name" {
  description = "A value to append to the EC2 identifer to create a unique name"
  default = "ec2-instance"
}

variable "number_servers" {
  default = 1
}
variable "enabled" {
  default = 1
}

variable "user_data" {
  default = ""
}

## EC2 specification
variable "ami_id" {
  # 091716275804/Ubuntu 16.04
  default = "ami-ab5e0ed8"
}
variable "instance_type" {
  default = "t2.nano"
}
variable "application_name" {
  default = "Change this"
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

## Keys
variable "key_name" {
  default = "Must Set"
}
variable "public_key" {
  default = "Must set"
}

variable "subnet_id" {}
