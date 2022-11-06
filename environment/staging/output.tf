output "bastion_public_IP" {
  value = module.staging_bastion.Bastion_IP
}
output "sonar_IP" {
  value = module.staging_sonarqube.sonar_IP
}
output "Jenkins_IP" {
  value = module.staging_jenkins.jenkins_IP
}
output "docker_IP" {
  value = module.staging_docker.Docker_IP
}
output "docker_lb_dns" {
  value = module.staging_docker_lb.Load_Balancer_dns
}
output "jenkins_lb_dns" {
  value = module.staging_jenkins_lb.jenkins_lb_dns
}
output "route53-name" {
  value = module.staging_route53.Route53_name
}
output "name_servers" {
  value = module.staging_route53.name_servers
}
output "ansible_private_IP" {
  value = module.staging_ansible.ansible_IP
}