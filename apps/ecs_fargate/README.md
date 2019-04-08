# Description
Module to create an ECS cluster using Fargate

## Code Example

```hcl-terraform
module "ecs_fargate_cluster" {
  source               = "git@github.com:albumprinter/eops_tf_modules.git//apps/ecs_fargate"
  cluster_name         = "MyCluster"
  task_role_arn        = "${aws_iam_role.task_role.arn}"
  execution_role_arn   = "${aws_iam_role.execution_role.arn}"
  cpu_value            = "256"
  memory_value         = "512"
  container_definition = "${data.template_file.container_definition.rendered}"
}
```