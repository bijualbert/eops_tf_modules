# Description
An example terraform module to create a stand-alone EC2 instance.  In addition to the  This module will provide a *security group* but you will have to provide the rules in your stack.

## required parameters
You should be looking to over-ride these parameters in your own stack module.

### tags
See[CoreWiki](https://corewiki.cimpress.net/wiki/Albumprinter_AWS_Tagging_standards) for minimum standards and some default settings for inspiration.
- variable "tags_purpose" {}
- variable "tags_cost_center" {}
- variable "tags_team" {}
- variable "tags_name" {}
- variable "tags_contact" {}

### Used in tags...and other places
- variable "description" {}
- variable "environment" {}
- variable "application_name" {}

### Security group
- variable "sg_name" {}
- variable "sg_description" {}

### Keys
You should specify a *public* key for connection to the EC2 instance(s). Use OpenSSH or putty to brew up a key pair.  If you use putty remember to convert to OpenSSH format.
- variable "key_name" {}
- variable "public_key" {}

### EC2 specification
Set in your stack, should be something like "${module.aws_account_core_data.private_subnets[0]}" so that the id is retrieved from the state file.
- variable subnet_id {}

you may wish to override the *ami* to a newer or AP release.
- variable "ami_id" {}

you may also want to override the instance_type.  This is best done in your stack definition in the <env>.tfvars so that you can size to the environment.
- variable "instance_type" {}

Want more servers?  Override this setting in your stack.  Again, this should be done in your <env>.tfvars so that the stack is sized correctly.
- variable "number_servers" {}