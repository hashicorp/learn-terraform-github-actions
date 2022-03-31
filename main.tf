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
    organization = "thezimmermanhome"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "random_pet" "bucket" {}

resource "aws_s3_bucket" "example" {
  bucket = random_pet.bucket
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls   = false
  block_public_policy = false
}


# output "s3bucket" {
#   value = "${aws_instance.web.public_dns}:8080"
# }

output "out" {
  value     = "xyz"
  sensitive = false
}
