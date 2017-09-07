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

variable "allow_remote_vpc_dns_resolution" {
  default = true
}

//variable "vpc_id" {}
//variable "peer_vpc_id" {}

variable "ecom1_sb_account_id" {
  description = "ecom1 sandbox account id"
  default = "047710374887"
}
variable "db_sb_account_id" {
  description = "db sandbox account id"
  default = "714256216940"
}