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


variable "period" {
  default = "1"
}
variable "alarm_threshold" {}
variable "alarm_action_arn" {}
variable "actions_enabled" {}
variable "retention_days" {
  default = "30"
}
variable "log_group_name" {
  default = "/aws/lambda/${var.app_name}"
}
variable "pattern" {
  default = "[type=REPORT,...,MemUsed,MemUnit]"
}
variable "action_enabled" {
  default = "true"
}

