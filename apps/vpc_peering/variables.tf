variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
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
variable "description" {}
variable "app_name" {}

variable "environment" {}
variable "variables" {
  default = ""
}
variable "enabled" {
  default = 1
}
variable "private" {
  default = false
}

variable "response_template" {
  type = "map"
  default ={
    "application/json" = ""
  }
}

variable "allow_remote_vpc_dns_resolution" {
  default = true
}
//variable "peer_owner_id" {}
variable "source_vpc_id" {}
variable "target_vpc_id" {}