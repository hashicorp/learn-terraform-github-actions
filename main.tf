resource "azurerm_resource_group" "wus-rg" {
  name     = "wus-rg"
  location = "West US"
}

resource "random_pet" "sg" {}

# resource "aws_instance" "web" {
#   ami                    = "ami-830c94e3"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.web-sg.id]

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World" > index.html
#               nohup busybox httpd -f -p 8080 &
#               EOF
# }

# resource "azurerm_" "web-sg" {
#   name = "${random_pet.sg.id}-sg"
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# output "web-address" {
#   value = "${aws_instance.web.public_dns}:8080"
# }
