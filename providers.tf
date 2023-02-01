provider "opentelekomcloud" {
  user_name   = var.username
  password    = var.password
  tenant_name = var.tenant_name
  domain_name = var.domain_name
  auth_url    = var.endpoint
}