terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 0.14"

  backend "remote" {
    organization = "exaf-epfl"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}


provider "digitalocean" {
  token = var.do_token
}

resource "random_pet" "sg" {}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "${random_pet.sg.id}-sg"
  region = "fra1"
  size   = "s-1vcpu-1gb"

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}

output "web-address" {
  value = web.public_ip
}
