terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "example-org-f085f7"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

variable "TERRAFORM_CLIENT_SECRET" {
  description = "The client secret"
  type        = string
  sensitive   = true
}

provider "keycloak" {
  client_id     = "terraform"
  client_secret = var.TERRAFORM_CLIENT_SECRET
  url           = "https://common-logon-dev.hlth.gov.bc.ca"
  realm         = "moh_applications"
}

resource "keycloak_openid_client" "clientName" {
  realm_id    = "moh_applications"
  client_id   = "new-client2"
  access_type = "CONFIDENTIAL"
  name        = "hi mom"
}
