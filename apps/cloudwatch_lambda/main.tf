provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  version = "~> 1.0"
  alias = "default"
  region = "eu-west-1"
}