output "aws_alb_app_url" {
  value       = module.alb.aws_alb_app_url
  description = "The public ALB DNS"
}

output "iam_publisher_access_key" {
  value       = module.iam.iam_publisher_access_key
  description = "AWS_ACCESS_KEY to publish to ECR"
}

output "iam_publisher_secret_key" {
  value       = module.iam.iam_publisher_secret_key
  description = "AWS_SECRET_ACCESS_KEY to upload to the ECR"
  sensitive   = true
}


output "ecr_url" {
  value       = module.ecr.ecr_url
  description = "The ECR repository URL"
}

output "ecr_repository_name" {
  value       = module.ecr.ecr_repository_name
  description = "The ECR repository name"
}

output "ecs_cluster" {
  value       = module.ecs.ecs_cluster
  description = "The ECS cluster name"
}

output "ecs_service" {
  value       = module.ecs.ecs_service
  description = "The ECS service name"
}