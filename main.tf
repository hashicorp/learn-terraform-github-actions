terraform {
  required_providers {
    uptimerobot = {
      source  = "louy/uptimerobot"
      version = "0.5.1"
    }
  }

  backend "remote" {
    organization = "GH_Test"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}


provider "uptimerobot" {
  api_key = "FakeKey"
}

resource "uptimerobot_monitor" "aaf_website" {
  friendly_name = "AAF Website"
  type          = "http"
  url           = "http://www.aaf.edu.au"
}
