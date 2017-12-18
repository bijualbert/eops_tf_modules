resource "aws_sqs_queue" "sqs_queue" {
  name                      = "${var.app_name}"
  message_retention_seconds = 1209600
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_error_queue.arn}\",\"maxReceiveCount\":${var.redrive_policy_retry_count}}"
}

resource "aws_sqs_queue_policy" "sqs_sns_policy" {
  queue_url = "${aws_sqs_queue.sqs_queue.id}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sns_subscription_arn}"
        }
      }
    },
     {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.replay_sns.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "sqs_error_queue" {
  name                      = "${var.app_name}-ERROR"
  message_retention_seconds = 1209600
}