terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "phytertek"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
# Cluster

variable "app" {
  default = "actions-tutorial"
}

resource "aws_kms_key" "kms-key" {
    deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "log-group" {
    name = "${var.app}-log-group"
}
resource "aws_ecs_cluster" "ecs-cluster" {
    name = "${var.app}-ecs-cluster"
    setting {
        name = "containerInsights"
        value = "enabled"
    }

    configuration {
      execute_command_configuration {
        kms_key_id = aws_kms_key.kms-key.arn
        logging = "OVERRIDE"
        log_configuration {
            cloud_watch_encryption_enabled = true
            cloud_watch_log_group_name = aws_cloudwatch_log_group.log-group.name
        }
      }
    }
}

resource "aws_ecs_cluster_capacity_providers" "ecs-capacity-providers" {
    cluster_name = aws_ecs_cluster.ecs-cluster.name
    capacity_providers = ["FARGATE_SPOT", "FARGATE"]
}