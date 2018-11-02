provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  version = "~> 1.0"
  alias = "default"
  region = "eu-west-1"
}

module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
  // For local development use instead:
  //  source = "../../data_providers/aws_account_core_data"
}
