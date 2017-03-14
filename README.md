## Synopsis

A set of core terraform modules for standardized infrastructure provisioning across multi-account life-cycles.

## Code Example

In order to provision the example standardized setup, create a terraform git repo and make sure it is registered 
as a jenkins infra terraform multi aws account lifecycles project.

```hcl-terraform
module "app_name" {
  source             = "git@github.com:albumprinter/eops_tf_modules.git//apps/sample_loadbalanced_application?ref=v0.1.10"
  description        = "Terraform Demo"
  environment        = "dev"
  application_name   = "app_name"
  ami_id             = "ami-405f7226"
  servers            = 2
}
```
### Supported Usage Examples:
```hcl-terraform
module "scheduled_lambda_app" {
  //  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/lambda_function_scheduled?ref=v0.2.1"
  source = "../eops_tf_modules/apps/lambda_function_scheduled"
  app_name = "lambda-cloudwatch-sample"
  description = "lambda-cloudwatch-sample"
  handler = "myHandler"
  filename = "filename.zip"
  schedule_expression = "rate(5 minutes)" // optional For example, "rate(5 minutes)" or "cron(0 20 * * ? *)"
  environment = "dev"
  tags_team = "eops"
  //  iam_policy_document = "{json policy}" // optional
  variables = "" // optional
  runtime = "dotnetcore1.0" // optional default:nodejs | nodejs4.3 | java8 | python2.7 | dotnetcore1.0 | nodejs4.3-edge
  memory_size = "128" //optional
  timeout = "3" // optional
  enabled = 1 // optional avail options: 1 | 0
}

module "scheduled_lambda_app_vpc" {
  //  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/lambda_function_scheduled_vpc?ref=v0.2.1"
  source = "../eops_tf_modules/apps/lambda_function_scheduled_vpc"
  app_name = "lambda-cloudwatch-sample-vpc"
  description = "lambda-cloudwatch-sample-in-vpc"
  handler = "myHandler"
  filename = "filename.zip"
  schedule_expression = "rate(5 minutes)" // optional For example, "rate(5 minutes)" or "cron(0 20 * * ? *)"
  environment = "dev"
  tags_team = "eops"
  //  iam_policy_document = "{json policy}" // optional
  variables = "" // optional
  runtime = "dotnetcore1.0" // optional default:nodejs | nodejs4.3 | java8 | python2.7 | dotnetcore1.0 | nodejs4.3-edge
  memory_size = "128" //optional
  timeout = "3" // optional
  enabled = 1 // optional avail options: 1 | 0
  private = true // optional
}
```


To get access to the core-infrastructure data (vpc's, subnets, regions, tags):
```hcl-terraform
module "aws_account_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
}
```
