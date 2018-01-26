# Autoscaling Group with ELB Module

## Usage instructions

The module uses the **autoscaling_group** module. 
Both modules accepts a number of variables, of which a few defaults have been set.

A few variables that are optional/need more context:

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

### Autoscaling Group with ELB Module
**elb_security_groups** (*optional*):
can contain a list of security group IDs. If this option is not passed, only the SG belonging to the ELB will be used.

**elb_listeners** (*required*):
a list with ELB listeners configuration

**elb_tags** (*required*)
Same as **asg_tags**, but for the ELB

**elb_sg_tags** (*required*)
Same as **asg_sg_tags**, but for the ELB SG


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

variable "target" {
  default = "HTTP:80/"
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
module "autoscaling_group_with_elb" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/autoscaling_group_with_elb?ref=0.9.0"

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
  elb_tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.environment}-${var.app_name}-${var.domain}-elb",
      "Description", "Classic Load Balancer for ${var.app_name}"
    )
  )}"
  elb_subnets = "${module.local_data.private_subnets}"
  elb_sg_tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.environment}-${var.app_name}-${var.domain}-elb-sg",
      "Description", "Security Group for ${var.app_name} Load Balancer"
    )
  )}"
  target = "${var.elb_hc_target}"
  elb_listeners = [
    {
      instance_port     = "15672"
      instance_protocol = "HTTP"
      lb_port           = "15672"
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = "5672"
      instance_protocol = "TCP"
      lb_port           = "5672"
      lb_protocol       = "TCP"
    }
  ]
  elb_sg_ingress = [
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