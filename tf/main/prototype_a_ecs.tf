# resource "aws_ecs_service" "hello_world" {
#   # "run and maintain your desired number of tasks simultaneously in an Amazon ECS cluster. How it works is that, if any of your tasks fail or stop for any reason, the Amazon ECS service scheduler launches another instance based on your task definition. It does this to replace it and thereby maintain your desired number of tasks in the service.""
#   name            = "hello-world"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.hello_world.arn
#   desired_count   = 1
#   network_configuration {
#     subnets          = [aws_subnet.public_a.id]
#     security_groups  = [aws_security_group.prototype_a.id]
#     assign_public_ip = true
#   }
#   launch_type = "FARGATE"
# }

# resource "aws_ecs_task_definition" "hello_world" {
#   family = "hello-world"
#   container_definitions = jsonencode([
#     {
#       name  = "hello-world"
#       image = "920394549028.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest"
#       # image     = "nginx:1.17.7"
#       cpu       = 128
#       memory    = 256
#       essential = true
#       portMappings = [
#         {
#           containerPort = 8080
#         }
#       ]
#       environment = [
#         {
#           name  = "secretMessage"
#           value = "My name is Refayat"
#         }
#       ]
#       # https://github.com/kanth1222/msk-ecs/blob/1f62babd2d10d2aee11f80044b01326380abde64/task-definition.tf
#       logConfiguration = {
#         logDriver = "awslogs"
#         options = {
#           awslogs-region        = "us-east-1"
#           awslogs-group         = "hello-world-container"
#           awslogs-stream-prefix = "ecs"
#         }
#       }
#       # https://github.com/cloudquery/cq-provider-aws/blob/35f5c13908ffdb3f91dd6da2d716004db9a3f2dd/terraform/ecs/modules/test/task_definitions.tf
#     }
#   ])
#   execution_role_arn = aws_iam_role.task_execution.arn
#   network_mode       = "awsvpc"
#   cpu                = 256
#   memory             = 512
#   # When you register a task definition, you can specify the total CPU and memory used for the task. This is separate from the cpu and memory values at the container definition level. For tasks that are hosted on Amazon EC2 instances, these fields are optional. For tasks that are hosted on Fargate (both Linux and Windows), these fields are required and there are specific values for both cpu and memory that are supported.
#   # you'll get a Terraform error like, "Error: failed creating ECS Task Definition (hello-world): ClientException: No Fargate configuration exists for given values: 128 CPU, 256 memory. See the Amazon ECS documentation for the valid values.", this happens if you set the container's cpu and memory levels to the same as the task's, i.e., you can't set the task's compute levels to the that of the container's, the task's needs to be at least 2x the container's cpu and memory
# }

# task definition parameters - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
# container definition parameters - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#standard_container_definition_params

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service

# https://appfleet.com/blog/automate-docker-container-deployment-to-aws-ecs-using-cloudformation/
# https://appfleet.com/blog/route-traffic-to-aws-ecs-using-application-load-balancer/

# without configuring an internet gateway for the subnet(s) the task is running in, it won't be able to pull an image (something public like nginx:1.17.7) from the internet - https://aws.amazon.com/premiumsupport/knowledge-center/ecs-pull-container-error/

# can't run regular `docker build` command on M1 ARM Mac to build Docker images, since Fargate underlying infrastructure is still (mostly) using more common x86-64 architecture - https://stackoverflow.com/questions/67361936/exec-user-process-caused-exec-format-error-in-aws-fargate-service
