# resource "aws_security_group" "prototype_b_alb" {
#   name   = "prototype-a-alb"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }

# resource "aws_security_group" "prototype_b_container_a" {
#   name   = "prototype-a-container-a"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # the ports here have to match the container port, so if you want to access a node.js container with the container exposed port set to 8080, this needs to be 8080
#   # conversely, if you want to access some other container, e.g., nginx:1.17.7 with the container exposed port set to 80, this needs to be 80

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }
