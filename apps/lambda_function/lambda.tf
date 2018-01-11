resource "aws_lambda_function" "app" {
  function_name = "${var.app_name}"
  description = "${var.description}"
  role = "${aws_iam_role.iam_for_app.arn}"
  s3_bucket = "${var.lambda_bucket_name}"
  s3_key = "builds/lambda/${var.app_name}/lambda.zip"
  //  s3_object_version = "$LATEST"
  handler = "${var.handler}"
  runtime = "${var.runtime}"
  memory_size = "${var.memory_size}"
  timeout = "${var.timeout}"
  environment {
    variables = "${var.variables}"
  }
  count            = "${var.enabled}"
}

resource "aws_iam_role" "iam_for_app" {
  name = "${var.app_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_policy_for_app" {
  name = "${var.app_name}"
  role = "${aws_iam_role.iam_for_app.id}"
  policy = "${var.iam_policy_document}"
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "${var.app_name}"
  retention_in_days = "${var.retention_days}"

  tags {
    Environment = "${var.environment}"
  }
}