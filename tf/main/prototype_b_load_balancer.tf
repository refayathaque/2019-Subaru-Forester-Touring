resource "aws_lb" "prototype_b" {
  name     = "prototype-b"
  internal = false
  # "For Scheme, choose Internet-facing or Internal. An internet-facing load balancer routes requests from clients to targets over the internet. An internal load balancer routes requests to targets using private IP addresses."
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_new.id]
  subnets            = [aws_subnet.public_b.id, aws_subnet.private_c.id]
  # two subnets (in different AZs) are always required in ALBs, and for this example, they must be the public one the ALB is placed in and the private one the ECS service is in
  # error creating application Load Balancer: ValidationError: At least two subnets in two different Availability Zones must be specified
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "reads_from_dydb_service" {
  name        = "reads-from-dydb-service"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  health_check {
    port     = "traffic-port"
    protocol = "HTTP"
    path     = "/"
  }
  depends_on = [aws_lb.prototype_b]
}

# Redirect to https listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.prototype_b.id
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Redirect traffic to target group
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.prototype_b.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.somtum_dot_io.arn
  default_action {
    target_group_arn = aws_lb_target_group.reads_from_dydb_service.id
    type             = "forward"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# how to set up ALBs for ECS - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-application-load-balancer.html
# how to set up SGs for ALB - https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-update-security-groups.html
# target group health checks - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#health_check
