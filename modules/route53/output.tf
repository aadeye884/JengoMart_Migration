output "Route53_name" {
  value = aws_route53_record.zone.name
}

output "name_servers" {
  value = aws_route53_zone.zone.name_servers
}