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
variable "filename" {}

variable "runtime" {
  default = "nodejs4.3"
}
variable "handler" {}
variable "environment" {}
variable "variables" {
  default = ""
}

variable "iam_policy_document" {}

variable "schedule_expression" {
  default = "rate(5 minutes)"
}
variable "memory_size" {
  default = "128"
}
variable "timeout" {
  default = "3"
}
variable "enabled" {
  default = 1
}
variable "private" {
  default = false
}