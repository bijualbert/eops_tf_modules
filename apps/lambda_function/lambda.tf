module "lambda_s3_bucket_object" {
  source = "../../apps/lambda_s3_bucket_object"
  lambda_bucket_name = "${var.lambda_bucket_name}"
  s3_object_key = "builds/lambda/${var.app_name}/lambda.zip"
  tags = "${local.tags}"
  providers = {
   aws = "aws"
  } 
}

resource "aws_lambda_function" "app" {
  function_name = "${var.app_name}"
  description = "${var.description}"
  role = "${aws_iam_role.iam_for_app.arn}"
  s3_bucket = "${var.lambda_bucket_name}"
  s3_key = "${module.lambda_s3_bucket_object.key}"
  handler = "${var.handler}"
  runtime = "${var.runtime}"
  memory_size = "${var.memory_size}"
  timeout = "${var.timeout}"
  environment {
    variables = "${var.variables}"
  }
  count            = "${var.enabled}"
  tags = "${local.tags}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
}

resource "aws_iam_role" "iam_for_app" {
  name = "${var.app_name}"
  assume_role_policy = "${var.assume_role_policy_document}"
}

resource "aws_iam_role_policy" "iam_policy_for_app" {
  name = "${var.app_name}"
  role = "${aws_iam_role.iam_for_app.id}"
  policy = "${var.iam_policy_document}"
}