# resource "aws_lb" "hello_world" {
#   name     = "hello-world"
#   internal = false
#   # "For Scheme, choose Internet-facing or Internal. An internet-facing load balancer routes requests from clients to targets over the internet. An internal load balancer routes requests to targets using private IP addresses."
#   load_balancer_type = "application"
#   subnets            = [aws_subnet.main_a.id, aws_subnet.main_b.id]
#   # required
#   enable_deletion_protection = false
# }

# resource "aws_lb_target_group" "hello_world_home" {
#   name        = "hello-world-home"
#   port        = 8080
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.main.id
#   target_type = "ip"
#   health_check {
#     port     = 8080
#     protocol = "HTTP"
#     path     = "/"
#   }
#   tags = {
#     "Name" = "hello-world-home"
#   }
# }

# resource "aws_lb_listener" "hello_world_home" {
#   load_balancer_arn = aws_lb.hello_world.arn
#   port              = "8080"
#   protocol          = "HTTP"
#   # ssl_policy        = "ELBSecurityPolicy-2016-08"
#   # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
#   # ^ will need for when I configure HTTPS
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.hello_world_home.arn
#   }
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# how to set up ALBs for ECS - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-application-load-balancer.html
# how to set up SGs for ALB - https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-update-security-groups.html
# target group health checks - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#health_check
