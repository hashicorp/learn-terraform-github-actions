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
    organization = "Demo-Lydia"

    workspaces {
      name = "learn-terraform-github-actions"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "web" {
  ami                    = "ami-02d0b1ffa5f16402d"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0d77553dc9abeae0e"

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World toto" > /var/www/html/index.html
              systemctl restart apache2
              EOF
}

tags = {
    Name = "ExampleAppServer"
  }

