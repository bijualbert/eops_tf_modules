resource "aws_sns_topic_subscription" "topic-subscription" {
  topic_arn = "${var.topic_arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${var.endpoint}"
  providers = {
   aws = "aws"
   //aws.default = "aws.default"
  }
}
