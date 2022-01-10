// Security group with no ingress rule
output "no-ingress-sg" {
  value = aws_security_group.no-ingress-sg.id
}