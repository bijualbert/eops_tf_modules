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
variable "tags_purpose" {
  default = ""
}
variable "description" {
  default = "WATSON-968 test metric"
}
variable "app_name" {}

variable "pattern" {
  default = "[type=REPORT,...,MemUsed,MemUnit]"
}
variable "alarm_threshold" {
  default =""
}

variable "period" {
  default = "60"  // 1 minutes
}

variable "log_group_name" {
  default = "/aws/lambda/${var.app_name}"
}

variable "action_enabled" {
  default = "true"
}

variable "alarm_action_arn" {  
}