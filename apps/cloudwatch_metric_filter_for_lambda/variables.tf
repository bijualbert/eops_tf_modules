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
variable "description" {
  default = "WATSON-968 test metric"
}
variable "app_name" {}
variable "environment" {}

variable "pattern" {
  default = "[type=REPORT,...,MemUsed,MemUnit]"
}