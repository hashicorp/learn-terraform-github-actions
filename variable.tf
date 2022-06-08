variable "aws_region" {
       description = "The AWS region to create things in."
       default     = "us-west-1"
}

variable "key_name" {
    description = " SSH keys to connect to ec2 instance"
    default     =  "yogender_new_aws_keypair"
}

variable "instance_type" {
    description = "instance type for ec2"
    default     =  "t2.micro"
}

variable "security_group" {
    description = "Name of security group"
    default     = "EC2-security-group"
}

variable "tag_name" {
    description = "Tag Name of for Ec2 instance"
    default     = "ec2-instance"
}
variable "ami_id" {
    description = "AMI for Ubuntu Ec2 instance"
    default     = "ami-0487b1fe60c1fd1a2"
}
