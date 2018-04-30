# Data sources
module "local_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/local-get-data"

  # See repo for possible outputs
}

//data "aws_caller_identity" "current" {}

//data "terraform_remote_state" "terraform-ap" {
//  backend = "s3"
//
//  config {
//    bucket = "${var.tf-remote-state-bucket-name}"
//    key    = "${data.aws_caller_identity.current.account_id}/vpcPeering_DB-ecom1/terraform.tfstate"
//    region = "eu-west-1"
//    acl    = "bucket-owner-full-control"
//  }
//}

provider "aws" {
  region = "eu-west-1"
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
