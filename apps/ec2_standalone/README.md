# Description
An example terraform module to create a stand-alone EC2 instance.

## requiried parameters
You should be looking to over-ride these parameters in your own stack module.

sg_name = unique name of security group

## Code Example


```hcl-terraform
module "rds" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/rds_mysql?ref=EOPS-3610"
//  source = "../eops_tf_modules/apps/rds_mysql"
  app_name = "rds"
  tags_cost_center = "CC443100"
  tags_team = "eops"
  description = "The rds for some app"
  enabled = 1
  account_type = "${var.account_type}"
  environment = "${var.environment}"
}
```