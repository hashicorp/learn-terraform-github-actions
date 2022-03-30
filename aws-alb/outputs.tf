output "aws_alb_target_group_arn" {
  value = aws_lb_target_group.group.arn
}

output "aws_alb_app_url" {
  value       = aws_lb.alb.dns_name
  description = "The public ALB DNS"
}