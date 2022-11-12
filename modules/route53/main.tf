# Route 53 Hosted Zone
resource "aws_route53_zone" "zone" {
  name          = var.domain_name
  force_destroy = true
}

# Route 53 A Record
resource "aws_route53_record" "zone" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "A"
  # ttl     = "300" - (Use when not associating route53 to a load balancer)
  # records = [aws_instance.Docker_Host.public_ip]
  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = false
  }
}