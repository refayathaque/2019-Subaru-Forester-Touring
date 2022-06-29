# resource "aws_security_group" "prototype_a" {
#   name   = "prototype-a"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     description = "Custom TCP"
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = [var.prototype_a_IP]
#   }
#   # the ports here have to match the container port, so if you want to access a node.js container with the container exposed port set to 8080, this needs to be 8080
#   # conversely, if you want to access some other container, e.g., nginx:1.17.7 with the container exposed port set to 80, this needs to be 80

#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [var.prototype_a_IP]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# why HTTPS 443 in this SG? - https://aws.amazon.com/premiumsupport/knowledge-center/ecs-pull-container-error/
