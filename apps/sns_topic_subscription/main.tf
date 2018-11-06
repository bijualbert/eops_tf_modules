provider "aws" {
}

provider "aws" {
  alias  = "default"
}


module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
  providers = { 
   aws = "aws.default" 
  } 
}

// For local development use instead:
//module "aws_core_data" {
//  source = "../../data_providers/aws_account_core_data"
//}