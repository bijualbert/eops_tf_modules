provider "aws" {
}

module "aws_core_data" {
  source = "../../data_providers/aws_account_core_data"
  providers = {
   aws = "aws"
  } 
}
