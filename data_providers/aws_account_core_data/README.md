## Code Example

main.tf
```hcl-terraform
module "aws_account_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
}

# SG for the loadbalancer to the instance traffic
resource "aws_security_group" "sg_application" {
  name        = "SG-${var.application_name}"
  description = "Allow inbound traffic for ${var.application_name}"
  vpc_id      = "${module.aws_account_core_data.vpc_id}"
}
```

# Info

Terraform module to read data from core-infra setup. This module will retrieve the info for the aws account where terraform is currently running from the centralized terraform-ap 
states bucket in the shared services awss account.

 bucket organization:
 
 ```
 s3://terraform-ap/
         |-- account-id/
                |--core-infra/
                    terraform.tfstate <--- statefile read via this module
                |--app-name-in-jenkins
                    terraform.tfstate

```

Everyone with access to the bucket has read level access to all the the account-id folders, whilst only able to write to 
the account-id folder from the account where terraform is running in. This is accomplished via an S3 bucket policy.

# Data
vpc_id
availability_zones
public_subnets
private_subnets
account_id
tags_business_unit
tags_environment
tags_type
tags_cost_center
tags_purpose
tags_team
tags_contact
tags_description