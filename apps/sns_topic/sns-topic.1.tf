resource "aws_sns_topic" "sns-topic1" {
  name = "${var.app_name}"
  provider = "aws.secondary"
}

resource "aws_sns_topic_policy" "default1" {
  arn = "${aws_sns_topic.sns-topic1.arn}"

  policy = "${data.aws_iam_policy_document.sns-topic1-policy.json}"
  provider = "aws.secondary"
}

data "aws_iam_policy_document" "sns-topic1-policy" {
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
      "${aws_sns_topic.sns-topic1.arn}",
    ]
  }
  provider = "aws.secondary"
}