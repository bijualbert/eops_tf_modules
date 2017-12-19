variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = ""
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {
  default = ""
}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}

variable "environment" {}
variable "variables" {
  default = ""
}

variable "availability_zone" {
  default = "eu-west-1a"
}

variable topic_arn {
  default = ""
}

variable protocol {
  default = ""
}

variable endpoint {
  default = ""
}