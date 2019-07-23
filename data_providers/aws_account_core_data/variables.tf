variable "region" {
  default = "eu-west-1"
}

variable "terraform_bucket" {
  default = "terraform-ap"
}

variable "vpc_name" {
  default = "main"
}

# dev, tst, acc or prd
variable "environment" {
  default = "dev"
}

# sandbox, non-prod or prod
variable "type" {
  default = "sandbox"
}