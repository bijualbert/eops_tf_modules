resource "aws_sns_topic" "sns-topic" {
  name = "${var.app_name}"
  provider = "aws.default"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.sns-topic.arn}"
  policy = "${data.aws_iam_policy_document.sns-topic-policy.json}"
  provider = "aws.default"
}

data "aws_iam_policy_document" "sns-topic-policy" {
  policy_id = "${var.app_name}-policy"
  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "*"]
    }
    resources = [
      "${aws_sns_topic.sns-topic.arn}",
    ]
  }
  provider = "aws.default"
}