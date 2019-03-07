variable "queue_name" {
}
variable "add_stale_message_cloudwatch" {
  default = 1
} 
variable "add_error_messages_cloudwatch" {
  default = 1
}
variable "extra_policy_statements"
{
  default = ""
}
variable "sns_alert_arn" {
  default = ""
}
