output "ecs_cluster" {
  value       = aws_ecs_cluster.main.name
  description = "The ECS cluster name"
}

output "ecs_service" {
  value       = aws_ecs_service.main.name
  description = "The ECS service name"
}
