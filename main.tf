

provider "aws" {
  region = var.aws_account_region
  access_key       = var.aws_access_key
  secret_key       = var.aws_secret_key
}

terraform {
	backend "remote" {
		organization = "3miliomclabs" # org name from step 2.
		workspaces {
			name = "Lattice_Test" # name for your app's state.
		}
	}
}

locals {
  tags = {
    "Entorno"        = var.workload_environment
    "Aplicacion" = var.workload_app_name
  }
}

module "secrets" {
  source             = "./aws-secrets"
  name               = var.workload_app_name
}

module "vpc" {
  source             = "./aws-vpc"
  name               = var.workload_app_name
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  environment        = var.workload_environment
}

module "security_groups" {
  source         = "./aws-security-groups"
  name           = var.workload_app_name
  vpc_id         = module.vpc.id
  environment    = var.workload_environment
  container_port = var.container_port
}

module "alb" {
  source              = "./aws-alb"
  name                = var.workload_app_name
  vpc_id              = module.vpc.id
  subnets             = module.vpc.public_subnets
  environment         = var.workload_environment
  alb_security_groups = [module.security_groups.alb]
  alb_tls_cert_arn    = var.tsl_certificate_arn
  health_check_path   = var.health_check_path
}


module "iam" {
  source      = "./aws-iam"
  name        = var.workload_app_name
  environment = var.workload_environment
}

module "ecr" {
  source      = "./aws-ecr"
  name        = var.workload_app_name
  environment = var.workload_environment
}

module "ecs" {
  source                      = "./aws-ecs"
  name                        = var.workload_app_name
  environment                 = var.workload_environment
  region                      = var.location
  subnets                     = module.vpc.private_subnets
  aws_alb_target_group_arn    = module.alb.aws_alb_target_group_arn
  ecs_service_security_groups = [module.security_groups.ecs_tasks]
  container_port              = var.container_port
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  service_desired_count       = var.service_desired_count
  container_image             = var.container_image
  iam_ecs_task_execution_role_arn = module.iam.iam_ecs_task_execution_role_arn
  container_environment = [
    { name = "LOG_LEVEL",
    value = "DEBUG" },
    { name = "PORT",
    value = var.container_port }
  ]
  
  #container_secrets      = module.secrets.secrets_map
  #aws_ecr_repository_url = module.ecr.aws_ecr_repository_url
  #container_secrets_arns = module.secrets.application_secrets_arn
}