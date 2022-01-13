terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  cloud {
-   organization = "REPLACE_ME"
+   organization = "YOUR_ORGANIZATION_NAME"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}}
