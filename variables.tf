variable "project_id" {
  type = string
}

variable "token" {
  type      = string
  sensitive = true
}

variable "location" {
    type = string
    default = "us-central1"
}