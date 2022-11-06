# Output for Resources
output "bastionSG" {
  value = aws_security_group.bastionSG.id
}
output "rdsSG" {
  value = aws_security_group.rdsSG.id
}
output "dockerSG" {
  value       = aws_security_group.dockerSG.id
}
output "docker_lbSG" {
  value       = aws_security_group.docker_lbSG.id
}