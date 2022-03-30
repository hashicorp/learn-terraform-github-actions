
output "ecr_url" {
  value       = aws_ecr_repository.main.repository_url
  description = "The ECR repository URL"
}

output "ecr_repository_name" {
  value       = aws_ecr_repository.main.name
  description = "The ECR repository name"
}