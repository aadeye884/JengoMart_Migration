output "ansible_IP" {
  value       = aws_instance.ansible.private_ip 
  description = "Ansible public IP"
}