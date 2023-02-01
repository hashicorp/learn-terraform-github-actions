terraform {
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = ">=1.32.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "daruzero"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}
