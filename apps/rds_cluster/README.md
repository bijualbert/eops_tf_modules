# Description
Terraform module to deploy rds cluster or database instances on RDS.

## Code Example

```hcl-terraform

module "rds" {
  //  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/rds_cluster?ref=feature/module_rds_cluster"
  source                      = "../eops_tf_modules/apps/rds_cluster"
  name                        = "rds-aurora-${var.environment}"
  tags_cost_center            = "CC443100"
  tags_team                   = "eops"
  tags_purpose                = "eops"
  description                 = "RDS test"
  account_type                = "${var.account_type}"
  environment                 = "${var.environment}"
  db_username                 = "${var.db_username}"
  db_multi_az                 = "${var.db_multi_az}"
  allowed_db_access_sg_groups = ["${aws_security_group.allowed_db_access_sg_groups.id}"]
  create_rds_cluster          = true
  createdby                   = "${var.createdby}"

  ## aurora or aurora-postgresql. !!!!Tested just for aurora!!!!
  engine         = "aurora-postgresql"
  engine_version = "9.6.3"
  instance_class = "db.t2.small"
}

```