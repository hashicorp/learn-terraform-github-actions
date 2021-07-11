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
  required_version = "~> 0.14"

  backend "remote" {
    organization = "gogobogo"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}


provider "aws" {
  profile = "pseg"
  region  = "eu-central-1"
}
# # Create access keys in aws cli cache
# data "external" "caller_id" {
#   program = ["aws", "sts", "get-caller-identity", "--profile", "hackatlon-admin", "--output", "json"]
# }

# # Fetch credentials from aws cli cache. Requires jq pkg
# data "external" "aws_creds" {
#   program    = ["jq", ".Credentials", "${pathexpand("~")}/${tolist(fileset(pathexpand("~"), ".aws/cli/cache/*.json"))[0]}"]
#   depends_on = [data.external.caller_id]
# }

# provider "aws" {
#   access_key = data.external.aws_creds.result["AccessKeyId"]
#   secret_key = data.external.aws_creds.result["SecretAccessKey"]
#   token      = data.external.aws_creds.result["SessionToken"]
#   region     = var.region
# }

resource "aws_s3_bucket" "terrabucket" {
  bucket = "pseg-terrabucket"
  acl = "private"

  tags = {
    Name = "pseg-terrabucket"
    Environment = "Dev"
  }
 }
