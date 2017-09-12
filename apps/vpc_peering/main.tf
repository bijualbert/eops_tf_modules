module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
}

// For local development use instead:
//module "aws_core_data" {
//  source = "../../data_providers/aws_account_core_data"
//}

provider "aws" {
  region = "eu-west-1"
  //  profile = "db-sandbox"
  alias = "source_provider"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.peer_source_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "source_vpc_main" {
  provider = "aws.source_provider"
  tags {
    Name = "main"
  }
}

data "aws_caller_identity" "source_account" {
  provider = "aws.source_provider"
}

provider "aws" {
  region = "eu-west-1"
  //  profile = "ecom1-sandbox"
  alias = "target_provider"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.peer_target_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "target_vpc_main" {
  provider = "aws.target_provider"
  tags {
    Name = "main"
  }
}


data "aws_caller_identity" "target_account" {
  provider = "aws.target_provider"
}
