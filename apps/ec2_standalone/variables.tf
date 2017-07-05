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
  default = "application_name Change this"
}
## Tags
variable "description" {}
variable "environment" {}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {}
variable "tags_purpose" {
  default = "development"
}

variable "tags_name" {}

## Security group
variable "sg_name" {}
### Security group rule
//variable "ingress_protocol" {}
//variable "ingress_to_port" {}
//variable "ingress_from_port" {}
//variable "egress_protocol" {}
//variable "egress_to_port" {}
//variable "egress_from_port" {}

variable "sg_description" {}

## Keys
variable "key_name" {}
variable "public_key" {}

#
variable "subnet_id" {}

variable "associtate_public_id"{
  default = false
}
