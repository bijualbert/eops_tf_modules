variable "account_type" {
  default = "sandbox"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}
variable "environment" {}

variable "iam_policy_document" {
  default = ""
}
variable "sns_extra_policy_statements" {
  default = ""
}
variable "error_queue_policy" {
  deafult = ""
}

variable "sns_subscription_arn" {
  default = ""
}

variable "redrive_policy_retry_count" {
  default = "10"
}

variable "sns_alert_arn" {
  default = ""
}

variable "receive_wait_time_seconds" {
  default = "20"
}

variable "message_retention_seconds" {
  default = "1209600"
}

variable "add_stale_message_cloudwatch" {
  default = 1
}

variable "add_error_messages_cloudwatch" {
  default = 1
}

variable "visibility_timeout_seconds" {
  default = 30
}

variable "sns_subscription_filters" {
  default = ""
}

