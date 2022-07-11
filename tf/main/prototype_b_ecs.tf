resource "aws_ecs_service" "reads_from_dydb" {
  name            = "reads-from-dydb"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.reads_from_dydb.arn
  desired_count   = 1
  network_configuration {
    subnets          = [aws_subnet.private_c.id]
    security_groups  = [aws_security_group.reads_from_dydb_service.id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.reads_from_dydb_service.arn
    container_name   = "reads-from-dydb"
    container_port   = 8080
  }
  launch_type = "FARGATE"
}

resource "aws_ecs_task_definition" "reads_from_dydb" {
  requires_compatibilities = ["FARGATE"]
  family                   = "reads-from-dydb"
  container_definitions = jsonencode([
    {
      name      = "reads-from-dydb"
      image     = "920394549028.dkr.ecr.us-east-1.amazonaws.com/reads-from-dydb:latest"
      cpu       = 128
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 8080
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region = var.region
          awslogs-group  = "reads-from-dydb-container"
          # make sure to create the log group as well, otherwise you'll get this error:
          # ResourceInitializationError: failed to validate logger args: create stream has been retried 1 times: failed to create Cloudwatch log stream: ResourceNotFoundException: The specified log group does not exist. : exit status 1
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  execution_role_arn = aws_iam_role.task_execution.arn
  task_role_arn      = aws_iam_role.reads_from_dydb_task.arn
  network_mode       = "awsvpc"
  cpu                = 256
  memory             = 512
}
