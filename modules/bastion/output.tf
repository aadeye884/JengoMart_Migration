output "Bastion_IP" {
  value       = aws_instance.bastion.public_ip
  description = "Bastion public IP"
}