//  Create a role that allows the EC2 instance to assume it
resource "aws_iam_role" "app_instance_role" {
  name = "${var.environment}-${var.domain}-${var.app_name}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

//  Create a instance profile for the role.
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "${var.environment}-${var.domain}-${var.app_name}"
  role = "${aws_iam_role.app_instance_role.name}"
}

resource "aws_iam_policy" "app_instance_policy" {
  name = "${var.environment}-${var.domain}-${var.app_name}-policy"
  path        = "/"
  description = "${var.role_policy_description}"

  policy = "${var.role_policy}"
}

//  Attach the policie to the role.
resource "aws_iam_policy_attachment" "instance_policy" {
  name       = "${var.environment}-${var.domain}-${var.app_name}"
  roles      = ["${aws_iam_role.app_instance_role.name}"]
  policy_arn = "${aws_iam_policy.app_instance_policy.arn}"
}

# Security Group for ASG

resource "aws_security_group" "asg_sg" {
  name = "${var.environment}-${var.team_name}-${var.app_name}-sg"
  vpc_id = "${var.vpc_id}"

  ingress = ["${var.asg_sg_ingress}"]

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = "${var.asg_sg_tags}"
}