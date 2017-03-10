provider "aws" {
  region = "${var.region}"
}

module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_core_data?ref=v0.1.1"
}