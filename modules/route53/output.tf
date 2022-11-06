output "Route53_name" {
  value = aws_route53_record.jengomart-lb.name
}

output "name_servers" {
  value = aws_route53_zone.jengomart-zone.name_servers
}