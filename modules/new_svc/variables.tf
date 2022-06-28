variable "service_name" {
  type = string
}

variable "workload_identity" {
  type = string
}

variable "service_account" {
  type = string
}

variable "min_replica" {
  type = number
  default = 1
}

variable "max_replica" {
  type = number
  default = 3
}

variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster" {
  type = string
}