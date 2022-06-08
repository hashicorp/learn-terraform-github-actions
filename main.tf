resource "aws_instance" "EC2-Instance" {
  ami             = var.ami_id
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

#Create security group with firewall rules
resource "aws_security_group" "security_grp" {
  name        = var.security_group
  description = "security group for EC2 instance"


 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}
