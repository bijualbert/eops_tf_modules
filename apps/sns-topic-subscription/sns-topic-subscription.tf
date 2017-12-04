resource "aws_sns_topic_subscription" "topic-subscription" {
  topic_arn = "${var.topic_arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${var.endpoint}"
}

resource "aws_sns_topic_subscription" "alert-subscription" {
  topic_arn = "${var.topic_arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${var.endpoint}"
}