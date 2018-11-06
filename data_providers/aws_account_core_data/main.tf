provider "aws" {
}

provider "aws" {
  alias  = "default"
  region = "${var.region}"
}

provider "aws" {
  alias  = "us-east-1"
}