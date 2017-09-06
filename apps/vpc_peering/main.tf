provider "aws" {
  region = "eu-west-1"
  //  profile = "ecom1-sandbox"
  alias = "ecom1-sb"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.ecom1_sb_account_id}:role/main_provisioner"
  }
}
provider "aws" {
  region = "eu-west-1"
  //  profile = "db-sandbox"
  alias = "db-sb"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.db_sb_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "ecom1_vpc_id" {
  provider = "aws.ecom1-sb"
  tags {
    Name = "main"
  }
}
data "aws_vpc" "db_vpc_id" {
  provider = "aws.db-sb"
  tags {
    Name = "main"
  }
}

//module "aws_core_data" {
//  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
//}

// For local development use instead:
//module "aws_core_data" {
//  source = "../../data_providers/aws_account_core_data"
//}

