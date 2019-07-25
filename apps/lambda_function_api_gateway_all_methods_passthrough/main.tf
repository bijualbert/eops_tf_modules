provider "aws" {
}

module "aws_core_data" {
  //source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
  source       = "../../data_providers/shared-vpc-data"
  account_type = "${var.account_type}"
  providers = {
    aws = "aws"
  }
}
