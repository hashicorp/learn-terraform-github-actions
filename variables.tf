variable "aws_account_region" {
  description = "El Client ID por el Service Principal de IaC de la Subscripción"
}

variable "aws_access_key" {
  description = "El Client Secret por el Service Principal de IaC de la Subscripción"
}

variable "aws_secret_key" {
  description = "El ID de la Subscripción de su cuenta Azure"
}

variable "workload_environment" {
  description = "El ID del Tenant ID de su cuenta Azure"
}

variable "workload_app_name" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "location" {
  description = "Nombre del ambiente, puede ser uno de las siguientes opciones: DSR,CRT,PRDDR,PRDLG,PRDAC o CIT"
}


variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  default     = 2
}

variable "container_port" {
  description = "The port where the Docker is exposed"
  default     = 8000
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = 256
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 512
}

variable "health_check_path" {
  description = "Http path for task health check"
  default     = "/health"
}

variable "tsl_certificate_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}

variable "container_image" {
  description = "docker image name"
}