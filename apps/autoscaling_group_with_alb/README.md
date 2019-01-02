# Autoscaling Group with alb Module

## Usage instructions

The (application) load balancer is setup with a single target group (that contains a health check), but no listeners. 
These need to be setup in the project itself and linked to the target group. The output "alb_tg_arn" can be used to 
reference this 

The module uses the **autoscaling_group** module. Both modules accepts a number of variables, of which a few defaults 
have been set. A few variables that are optional/need more context:

### Autoscaling Group Module
**security_groups** (*optional*):
can contain a list of security group IDs. If this option is not passed, only the SG belonging to the ASG will be used.

**asg_tags** (*required*):
a map of tags that will be added to the Autoscaling Group instances.

**asg_sg_tags** (*required*):
a map of tags that will be added to the Security Group belonging to the Autoscaling Group. 
See **Default tags example** for an example of the use of the **locals** type that allows for common tagging.   

**asg_sg_ingress** (*required*):
a list of security group ingress port configurations. 

### Autoscaling Group with ALB Module
**alb_security_groups** (*optional*):
can contain a list of security group IDs. If this option is not passed, only the SG belonging to the alb will be used.

**tg_port** (*required*):
port used for target group

**tg_protocol** (*required*):
protocol used for target group (either HTTP or HTTPS)

**alb_tags** (*required*)
Same as **asg_tags**, but for the alb

**alb_sg_tags** (*required*)
Same as **asg_sg_tags**, but for the alb SG


### Defaults

```hcl
variable "is_internal" {
  default = false
}

variable "healthy_threshold" {
  default = 2
}

variable "unhealthy_threshold" {
  default = 2
}

variable "timeout" {
  default = 3
}

variable "health_check_path" {
  default = "/"
}

variable "interval" {
  default = 10
}

variable "cross_zone_load_balancing" {
  default = true
}

variable "idle_timeout" {
  default = 300
}

variable "connection_draining" {
  default = true
}

variable "connection_draining_timeout" {
  default = 300
}
```

See the example for more information. 

## Example:

```hcl
module "autoscaling_group_with_alb" {
  source = "git@github.com:albumprinter/eops-tf-modules.git//apps/autoscaling_group_with_alb?ref=0.15.6"

  environment = "${var.environment}"
  app_name = "${var.app_name}"
  domain = "${var.domain}"
  team_name = "${var.team}"
  subnet_ids = ["${module.local_data.private_subnets}"]
  vpc_id = "${module.local_data.vpc_id}"

  ami_id = "${data.aws_ami.ami_data.id}"
  instance_type = "${var.aws_instance_type}"
  aws_key_name = "${aws_key_pair.rabbitmq_key_pair.key_name}"
  desired_nodes = "${var.desired_nodes}"

  user_data = "${data.template_file.user_data.rendered}"
  security_groups = [
    "${aws_security_group.ssh_access.id}"
  ]
  asg_sg_ingress = [
    {
      from_port   = 15672
      to_port     = 15672
      protocol    = "tcp"
      cidr_blocks = ["${var.allowed_cidrs}"]
    },
    {
      from_port   = 5672
      to_port     = 5672
      protocol    = "tcp"
      cidr_blocks = ["${var.allowed_cidrs}"]
    },
    {
      from_port   = "4369"
      to_port     = "4369"
      protocol    = "tcp"
      self = true
    },
    {
      from_port   = "25672"
      to_port     = "25672"
      protocol    = "tcp"
      self = true
    }
  ]
  asg_sg_tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.environment}-${var.app_name}-${var.domain}-sg",
      "Description", "Security Group for ${var.app_name}"
    )
  )}"
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

  is_internal = "${var.is_internal}"
  alb_tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.environment}-${var.app_name}-${var.domain}-alb",
      "Description", "Classic Load Balancer for ${var.app_name}"
    )
  )}"
  alb_subnets = "${module.local_data.private_subnets}"
  alb_sg_tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.environment}-${var.app_name}-${var.domain}-alb-sg",
      "Description", "Security Group for ${var.app_name} Load Balancer"
    )
  )}"
  health_check_path = "${var.alb_hc_target}"
  alb_sg_ingress = [
    {
      from_port   = 15672
      to_port     = 15672
      protocol    = "tcp"
      cidr_blocks = ["${var.allowed_cidrs}"]
    },
    {
      from_port   = 5672
      to_port     = 5672
      protocol    = "tcp"
      cidr_blocks = ["${var.allowed_cidrs}"]
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