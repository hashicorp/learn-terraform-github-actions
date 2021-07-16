provider "aws" {
  region = "us-west-2"
}

terraform {
  required_providers {
    nsxt = {
       source = "vmware/nsxt"
       version = ">= 3.1.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = "~> 0.14"

  backend "remote" {
    organization = "Bubibi"

    workspaces {
      name = "netmemo"
    }
  }
}

provider "nsxt" {
    host = "bubibimanlivebox.ddns.net"
    username = "admin"
    password = var.password
    allow_unverified_ssl = true
    max_retries = 10
    retry_min_delay = 500
    retry_max_delay = 5000
    retry_on_status_codes = [429]
}


resource "nsxt_policy_tier1_gateway" "tier1_gw" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = "T1-TFC-test"
  route_advertisement_types = ["TIER1_CONNECTED"]
}
