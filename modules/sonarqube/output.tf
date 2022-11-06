output "sonar_IP" {
  value       = aws_instance.Sonarqube_Server.public_ip
  description = "Sonarqube public IP"
}