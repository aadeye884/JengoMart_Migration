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
output "jenkinsSG" {
  value       = aws_security_group.jenkinsSG.id
}
output "ansibleSG" {
  value = aws_security_group.ansibleSG.id  
}
output "sonarSG" {
  value = aws_security_group.sonarSG.id 
}

# Output for Loadbalancers
output "docker_lbSG" {
  value       = aws_security_group.docker_lbSG.id
}
output "jenkins_lbSG" {
  value       = aws_security_group.jenkins_lbSG.id
}