output "bastion_public_IP" {
  value = module.staging_bastion.Bastion_IP
}
output "docker_IP" {
  value = module.staging_docker.Docker_IP
}
output "docker_lb_dns" {
  value = module.staging_docker_lb.Load_Balancer_dns
}
output "route53-name" {
  value = module.staging_route53.Route53_name
}
output "name_servers" {
  value = module.staging_route53.name_servers
}