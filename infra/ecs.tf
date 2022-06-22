# resource "aws_ecs_cluster" "main" {
#   # logical grouping of tasks or services
#   name = "main"
# }

# resource "aws_ecs_service" "hello_world" {
#   # run and maintain your desired number of tasks simultaneously in an Amazon ECS cluster. How it works is that, if any of your tasks fail or stop for any reason, the Amazon ECS service scheduler launches another instance based on your task definition. It does this to replace it and thereby maintain your desired number of tasks in the service.
#   name            = "hello-world"
#   launch_type     = "FARGATE"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.hello_world.arn
#   desired_count   = 2
#   #   load_balancer {
#   #     target_group_arn = aws_lb_target_group.foo.arn
#   #     container_name   = "mongo"
#   #     container_port   = 8080
#   #   }

#   network_configuration {
#     subnets          = [aws_subnet.main_a.id, aws_subnet.main_b.id]
#     security_groups  = [aws_security_group.allow_http_and_https_from_home.id]
#     assign_public_ip = true
#   }
# }

# resource "aws_ecs_task_definition" "hello_world" {
#   family = "hello-world"
#   container_definitions = jsonencode([
#     {
#       name  = "hello-world"
#       image = "920394549028.dkr.ecr.us-east-1.amazonaws.com/hello-world:x86"
#       # image     = "nginx:1.17.7"
#       cpu       = 256
#       memory    = 512
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
#           awslogs-group         = "hello-world-task"
#           awslogs-stream-prefix = "ecs"
#         }
#       }
#       # https://github.com/cloudquery/cq-provider-aws/blob/35f5c13908ffdb3f91dd6da2d716004db9a3f2dd/terraform/ecs/modules/test/task_definitions.tf
#     }
#   ])
#   execution_role_arn = aws_iam_role.hello_world_task_execution.arn
#   network_mode       = "awsvpc"
#   cpu                = 1024
#   memory             = 2048
#   # When you register a task definition, you can specify the total CPU and memory used for the task. This is separate from the cpu and memory values at the container definition level. For tasks that are hosted on Amazon EC2 instances, these fields are optional. For tasks that are hosted on Fargate (both Linux and Windows), these fields are required and there are specific values for both cpu and memory that are supported.
# }

# task definition parameters - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
# container definition parameters - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#standard_container_definition_params

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service

# https://appfleet.com/blog/automate-docker-container-deployment-to-aws-ecs-using-cloudformation/
# https://appfleet.com/blog/route-traffic-to-aws-ecs-using-application-load-balancer/

# without configuring an internet gateway for the subnet(s) the task is running in, it won't be able to pull an image (something public like nginx:1.17.7) from the internet - https://aws.amazon.com/premiumsupport/knowledge-center/ecs-pull-container-error/

# can't run regular `docker build` command on M1 ARM Mac to build Docker images, since Fargate underlying infrastructure is still (mostly) using more common x86-64 architecture - https://stackoverflow.com/questions/67361936/exec-user-process-caused-exec-format-error-in-aws-fargate-service
