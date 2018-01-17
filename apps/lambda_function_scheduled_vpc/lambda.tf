resource "aws_lambda_function" "app" {
  s3_bucket = "${var.lambda_bucket_name}"
  s3_key = "builds/lambda/${var.app_name}/lambda.zip"
  function_name = "${var.app_name}"
  description = "${var.description}"
  role = "${aws_iam_role.iam_for_app.arn}"
  handler = "${var.handler}"
  runtime = "${var.runtime}"
  memory_size = "${var.memory_size}"
  timeout = "${var.timeout}"
  vpc_config = {
    subnet_ids = ["${split( ",", var.private == 1 ?   join(",", module.aws_core_data.private_subnets) :  join(",", concat(module.aws_core_data.private_subnets,module.aws_core_data.public_subnets)))}"]
    security_group_ids = ["${aws_security_group.sg_for_app.id}"]
  }
  count            = "${var.enabled}"
}

resource "aws_lambda_permission" "cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.app.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.app.arn}"
  count         = "${var.enabled}"
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

resource "aws_security_group" "sg_for_app" {
  name = "${var.app_name}"
  description = "Allow all inbound traffic for the scheduled lambda function"
  vpc_id = "${module.aws_core_data.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}