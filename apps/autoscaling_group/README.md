# Autoscaling Group Module

## Usage instructions

The module accepts a number of variables, of which a few defaults have been set.

A few variables that are optional/need more context:

**security_groups** (*optional*):
can contain a list of security group IDs. If this option is not passed, only the SG belonging to the ASG will be used.

**asg_tags** (*required*):
a map of tags that will be added to the Autoscaling Group instances.

**asg_sg_tags** (*required*):
a map of tags that will be added to the Security Group belonging to the Autoscaling Group. 
See **Default tags example** for an example of the use of the **locals** type that allows for common tagging.   

**asg_sg_ingress** (*required*):
a list of security group ingress port configurations. 


### Defaults

```hcl

variable "associate_public_ip" {
  default = false
}

variable "role_policy" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1468377974000",
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingInstances",
                "ec2:DescribeInstances"
            ],
            "Resource": ["*"]
        }
    ]
}
    EOF
}

variable "role_policy_description" {
  default = "This policy is used for Autoclustering features."
}
```



See the example for more information. 

## Example:

```hcl
module "autoscaling_group" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/autoscaling_group?ref=0.9.0"

  environment = "${var.environment}"
  app_name = "${var.app_name}"
  domain = "${var.domain}"
  team_name = "${var.team}"
  subnet_ids = [
    "${module.local_data.private_subnets}"]
  vpc_id = "${module.local_data.vpc_id}"

  ami_id = "${data.aws_ami.packer_consul_ami_data.id}"
  instance_type = "${var.instance_type}"
  desired_nodes = "${var.desired_nodes}"
  aws_key_name = "${aws_key_pair.consul_key_pair.key_name}"
  user_data = "${data.template_file.user_data.rendered}"
  security_groups = [
    "${aws_security_group.consul_ssh_access.id}"
  ]
  asg_tags = [
    {
      key = "Name"
      value = "${var.environment}-${var.domain}-${var.app_name}"
      propagate_at_launch = true
    },
    {
      key = "${var.ec2_tag_key}"
      value = "${var.ec2_tag_value}"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key = "Cost Center"
      value = "${var.cost_center}"
      propagate_at_launch = true
    },
    {
      key = "Team"
      value = "${var.team}"
      propagate_at_launch = true
    },
    {
      key = "Description"
      value = "${var.environment}-${var.domain}-${var.app_name} Node"
      propagate_at_launch = true
    }
  ]
  asg_sg_tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.environment}-${var.app_name}-${var.domain}-sg",
      "Description", "Security Group for ${var.app_name}"
    )
  )}"
  asg_sg_ingress = [
    {
      from_port = "8300"
      to_port = "8302"
      protocol = "tcp"
      cidr_blocks = [
        "${var.consul_cidrs}"
      ]
    }
  ]
}
```

## Default tags example
```hcl
locals {
  common_tags = {
    "Cost Center" = "${var.cost_center}"
    Team = "${var.team}"
    Environment = "${var.environment}"
  }
}
```