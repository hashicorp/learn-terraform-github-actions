terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "pathivadaorg"

    workspaces {
      name = "demo-github-actions"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_pet" "sg" {}

#data "aws_ami" "ubuntu" {
#  most_recent = true
#
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#  }
#
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }
#
#  owners = ["099720109477"] # Canonical
#}
#
#resource "aws_instance" "web" {
#  ami                    = data.aws_ami.ubuntu.id
#  instance_type          = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.web-sg.id]
#
#  user_data = <<-EOF
#              #!/bin/bash
#              apt-get update
#              apt-get install -y apache2
#              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
#              echo "Hello World" > /var/www/html/index.html
#              systemctl restart apache2
#              EOF
#}
#
#resource "aws_security_group" "web-sg" {
#  name = "${random_pet.sg.id}-sg"
#  ingress {
#    from_port   = 8080
#    to_port     = 8080
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  // connectivity to ubuntu with mp1 mirrors is required to run `apt-get update` and `apt-get install apache2 mp3`
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#// new code by murali on july 12-1
#
##----- july 12 changes security_controls_scp/modules/account/deny_region_interaction.tf----#
#
#data "aws_iam_policy_document" "deny_region_interaction" {
#  statement {
#    sid = "DenyRegionDisableEnable"
#
#    actions = [
#      "account:EnableRegion",
#      "account:DisableRegion"
#    ]
#
#    resources = [
#      "*",
#    ]
#
#    effect = "Deny"
#  }
#}
#
#resource "aws_organizations_policy" "deny_region_interaction" {
#  name        = "Deny Region Interaction"
#  description = "Deny the ability to enable or disable a region."
#
#  content = data.aws_iam_policy_document.deny_region_interaction.json
#}
#
#resource "aws_organizations_policy_attachment" "deny_region_interaction_attachment" {
#  policy_id = aws_organizations_policy.deny_region_interaction.id
#  target_id = var.target_id
#  //target_id = "ou-a6ih-akiwo6r2"
#}
#
#
#
#// Require MFA
##----- testing on july 12 security_controls_scp/modules/ec2/require_mfa_actions.tf----#
#
### Requires a MFA'd account to perform certain EC2 Actions
#
#data "aws_iam_policy_document" "require_mfa_ec2_actions" {
#  statement {
#    sid = "RequireMFAEC2"
#
#    actions = [
#      "ec2:StopInstances",
#      "ec2:TerminateInstances",
#      "ec2:SendDiagnosticInterrupt",
#    ]
#
#    resources = [
#      "*",
#    ]
#
#    effect = "Deny"
#
#    condition {
#      test     = "BoolIfExists"
#      variable = "aws:MultiFactorAuthPresent"
#
#      values = [
#        "false",
#      ]
#    }
#  }
#}
#
#resource "aws_organizations_policy" "require_mfa_ec2_actions" {
#  name        = "Require MFA EC2 Actions"
#  description = "Require MFA Stopping or Deleting EC2 Instances"
#
#  content = data.aws_iam_policy_document.require_mfa_ec2_actions.json
#}
#
#resource "aws_organizations_policy_attachment" "require_mfa_ec2_actions_attachment" {
#  policy_id = aws_organizations_policy.require_mfa_ec2_actions.id
#  target_id = var.target_id
#}



# permission set example - bucket test1

data "aws_ssoadmin_instances" "example" {}

resource "aws_ssoadmin_permission_set" "example" {
  name         = "Example"
  instance_arn = tolist(data.aws_ssoadmin_instances.example.arns)[0]
}

data "aws_iam_policy_document" "example" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:PutObject",
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:GetBucketLocation",
      "s3:PutBucketOwnershipControls",
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

#resource "aws_ssoadmin_permission_set_inline_policy" "example" {
#  inline_policy      = data.aws_iam_policy_document.example.json
#  instance_arn       = aws_ssoadmin_permission_set.example.instance_arn
#  permission_set_arn = aws_ssoadmin_permission_set.example.arn
#}

resource "aws_ssoadmin_managed_policy_attachment" "example" {
  instance_arn       = data.aws_iam_policy_document.example.json
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  permission_set_arn = aws_ssoadmin_permission_set.example.arn
}

#  managed_policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess, arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess, arn:aws:iam::aws:policy/AmazonEC2FullAccess, arn:aws:iam::aws:policy/AmazonS3FullAccess, arn:aws:iam::aws:policy/CloudWatchFullAccess"



#
#AWSLambda_FullAccess
#AWSCloudTrailReadOnlyAccess
#AmazonEC2FullAccess
#AmazonS3FullAccess
#cloudwatch:* full access


#output "web-address" {
#  value = "${aws_instance.web.public_dns}:8080"
#}
