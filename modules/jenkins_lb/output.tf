output "jenkins_lb_dns" {
  value = aws_elb.jenkins_lb.dns_name
}
