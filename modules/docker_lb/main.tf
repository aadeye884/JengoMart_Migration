# Application Load Balancer 
resource "aws_lb" "jengomart-alb" {
  name                       = "jengomart-alb"
  security_groups            = var.vpc_security_group_ids
  subnets                    = var.subnet_id
  load_balancer_type         = "application"
}

# Load Balancer Listener
resource "aws_lb_listener" "jengomart-alb-listener" {
  load_balancer_arn = aws_lb.jengomart-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jengomart-tg.arn
  }
}

# Load Balancer Target Group
resource "aws_lb_target_group" "jengomart-tg" {
  name     = "jengomart-tg"
  vpc_id   = var.vpc_name
  port     = 8080
  protocol = "HTTP"
    health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
  }
}
