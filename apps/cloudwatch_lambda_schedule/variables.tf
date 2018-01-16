variable "region" {
  default = "eu-west-1"
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

variable "lambda_arn" {}
variable "enabled" {}
variable "schedule_expression" {
  default = "rate(5 minutes)"
}

