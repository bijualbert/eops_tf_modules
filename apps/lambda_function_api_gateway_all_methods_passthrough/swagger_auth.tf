module "api_gateway_resource_iam_auth" {
  source                                  = "git@github.com:albumprinter/eops_tf_modules.git//apps/api_gateway_resource_iam_auth?ref=v0.9.2"
  enable                                  = "${var.swagger_auth}"
  resource_path                           = "${var.swagger_resource_path}"
  api_gateway_rest_api_id                 = "${aws_api_gateway_rest_api.app.id}"
  api_gateway_rest_api_root_resource_id   = "${aws_api_gateway_rest_api.app.root_resource_id}"
  api_gateway_integration_uri             = "${aws_api_gateway_integration.app_integration.uri}"
  api_gateway_integration_credentials     = "${aws_api_gateway_integration.app_integration.credentials}"
}