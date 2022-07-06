# resource "aws_ecs_service" "reads_from_dydb" {
#   name            = "reads-from-dydb"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.reads_from_dydb.arn
#   desired_count   = 1
#   network_configuration {
#     subnets = [aws_subnet.public_a.id, aws_subnet.public_b.id]
#     # ^ using same ones as prototype-a because we need the IG to be able to pull images from ECR
#     security_groups  = [aws_security_group.reads_from_dydb.id]
#     assign_public_ip = true
#   }
#   launch_type = "FARGATE"
# }

# resource "aws_ecs_task_definition" "reads_from_dydb" {
#   family = "container-a"
#   container_definitions = jsonencode([
#     {
#       name      = "container-a"
#       image     = "920394549028.dkr.ecr.us-east-1.amazonaws.com/reads-from-dydb:latest"
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
#           awslogs-group         = "reads-from-dydb"
#           awslogs-stream-prefix = "ecs"
#         }
#       }
#     }
#   ])
#   execution_role_arn = aws_iam_role.hello_world_task_execution.arn
#   # ^ using same one as hello-world because permissions (for execution only) required will be the same, will need to have a task role with access to dydb
#   network_mode = "awsvpc"
#   cpu          = 128
#   memory       = 256
# }
