# resource "aws_lb" "prototype_b" {
#   name     = "prototype-b"
#   internal = false
#   # "For Scheme, choose Internet-facing or Internal. An internet-facing load balancer routes requests from clients to targets over the internet. An internal load balancer routes requests to targets using private IP addresses."
#   load_balancer_type = "application"
#   subnets            = [aws_subnet.main_a.id, aws_subnet.main_b.id]
#   # required
#   enable_deletion_protection = false
# }

# resource "aws_lb_target_group" "prototype_b_container_a" {
#   name        = "container-a"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.main.id
#   target_type = "ip"
#   health_check {
#     port     = "traffic-port"
#     protocol = "HTTP"
#     path     = "/"
#   }
# }

# resource "aws_lb_listener" "prototype_b_container_a" {
#   load_balancer_arn = aws_lb.prototype_b.arn
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.prototype_b_container_a.arn
#   }
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# how to set up ALBs for ECS - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-application-load-balancer.html
# how to set up SGs for ALB - https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-update-security-groups.html
# target group health checks - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#health_check
