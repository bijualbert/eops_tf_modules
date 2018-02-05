resource "aws_api_gateway_resource" "resource_parent" {
  parent_id   = "${var.api_gateway_rest_api_root_resource_id}"
  rest_api_id = "${var.api_gateway_rest_api_id}"
  path_part   = "${var.resource_path}"
  count       = "${var.enable}"
}

resource "aws_api_gateway_resource" "resource" {
  parent_id   = "${aws_api_gateway_resource.resource_parent.id}"
  rest_api_id = "${var.api_gateway_rest_api_id}"
  path_part   = "{proxy+}"
  count       = "${var.enable}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id      = "${var.api_gateway_rest_api_id}"
  resource_id      = "${aws_api_gateway_resource.resource.id}"
  http_method      = "${var.resource_http_method}"
  authorization    = "AWS_IAM"
  count            = "${var.enable}"
}

resource "aws_api_gateway_integration" "integration" {
  http_method             = "${aws_api_gateway_method.method.http_method}"
  rest_api_id             = "${var.api_gateway_rest_api_id}"
  resource_id             = "${aws_api_gateway_resource.resource.id}"
  type                    = "${var.api_gateway_integration_type}"
  integration_http_method = "${var.api_gateway_integration_method}"
  uri                     = "${var.api_gateway_integration_uri}"
  credentials             = "${var.api_gateway_integration_credentials}"
  count                   = "${var.enable}"
}