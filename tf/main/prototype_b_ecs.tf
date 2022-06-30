# resource "aws_ecs_service" "prototype_b_container_a" {
#   name            = "prototype-b-container-a"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.container_a.arn
#   desired_count   = 1
#   network_configuration {
#     subnets = [aws_subnet.main_a.id, aws_subnet.main_b.id]
#     # ^ using same ones as prototype-a because we need the IG to be able to pull images from ECR
#     security_groups  = [aws_security_group.prototype_b_container_a.id]
#     assign_public_ip = true
#   }
#   launch_type = "FARGATE"
# }

# resource "aws_ecs_task_definition" "container_a" {
#   family = "container-a"
#   container_definitions = jsonencode([
#     {
#       name      = "container-a"
#       image     = "920394549028.dkr.ecr.us-east-1.amazonaws.com/container-a:x86"
#       cpu       = 128
#       memory    = 256
#       essential = true
#       portMappings = [
#         {
#           containerPort = 8080
#         }
#       ]
#       logConfiguration = {
#         logDriver = "awslogs"
#         options = {
#           awslogs-region        = "us-east-1"
#           awslogs-group         = "prototype-b-container-a"
#           awslogs-stream-prefix = "ecs"
#         }
#       }
#     }
#   ])
#   execution_role_arn = aws_iam_role.hello_world_task_execution.arn
#   # ^ using same one as prototype-a because permissions required will be the same
#   network_mode = "awsvpc"
#   cpu          = 128
#   memory       = 256
# }
