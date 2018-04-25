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
  vpc_config = {
    subnet_ids = ["${split( ",", var.private == 1 ?   join(",", module.aws_core_data.private_subnets) :  join(",", concat(module.aws_core_data.private_subnets,module.aws_core_data.public_subnets)))}"]
    security_group_ids = ["${aws_security_group.sg_for_app.id}"]
  }
  environment {
    variables = "${var.variables}"
  }
  count            = "${var.enabled}"
  tags = "${local.tags}"
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

  tags = "${local.tags}"
}