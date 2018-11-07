provider "aws" {
}

provider "aws" {
  alias  = "secondary"
}

# provider "aws" {
#   alias  = "us-east-1"
# }

module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
  providers = {
   aws = "aws"
   //aws.default = "aws.default"
  } 
}