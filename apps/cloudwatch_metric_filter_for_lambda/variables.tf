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
  default = "report_name = "REPORT", request_id_name = "RequestId:", request_id_value, duration_name = "Duration:", duration_value, duration_unit = "ms", billed_duration_name_1 = "Billed", bill_duration_name_2 = "Duration:", billed_duration_value, billed_duration_unit = "ms", memory_size_name_1 = "Memory", memory_size_name_2 = "Size:", memory_size_value, memory_size_unit = "MB", max_memory_used_name_1 = "Max", max_memory_used_name_2 = "Memory", max_memory_used_name_3 = "Used:", max_memory_used_value, max_memory_used_unit = "MB"]"
}