variable "environment" {
  type    = string
  default = "staging"
}

variable "default_tags" {
  default = {
    Name      = "test"
    Terraform = "true"
  }
}
