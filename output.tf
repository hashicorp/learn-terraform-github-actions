output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}