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
    organization = "munir"

    workspaces {
      name = "gh-actions"
    }
  }
}
provider "aws" {
  region  = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0d75513e7706cf2d9"
  instance_type = "t2.micro"
  vpc_security_group_ids= [
      aws_security_group.allow_ssh.id]
  key_name      = "demo-key-2"

 
   tags = {
    Name = "Ubuntu server"
  }
  user_data = <<EOF
            #!/bin/bash
            echo "foo" | sudo tee /home/hello-world.txt
            EOF
  
}

resource "null_resource" "copy_text_file" {

  connection {
      type        = "ssh"
      host        = aws_instance.app_server.public_ip
      user        = "ubuntu"
      private_key = file("/users/munir/downloads/demo-key-2.pem")
      timeout     = "4m"
   }
  provisioner "file" {
    source  = "hello-world.txt"
    destination = "/tmp/hello-world.txt"
  }
  
   provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "sudo mv hello-world.txt /home"
    ]
  }
   depends_on=[ aws_instance.app_server ]

}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id="vpc-00ab2a22fdcff6d62"

    ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}