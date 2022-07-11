resource "aws_ecs_service" "reads_from_dydb" {
  name            = "reads-from-dydb"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.reads_from_dydb.arn
  desired_count   = 1
  network_configuration {
    subnets          = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups  = [aws_security_group.reads_from_dydb_task.id]
    assign_public_ip = false
  }
  launch_type = "FARGATE"
}

resource "aws_ecs_task_definition" "reads_from_dydb" {
  family = "reads-from-dydb"
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
          awslogs-region        = "us-east-1"
          awslogs-group         = "reads-from-dydb"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  execution_role_arn = aws_iam_role.task_execution.arn
  task_role_arn = aws_iam_role.reads_from_dydb_task.arn
  network_mode = "awsvpc"
  cpu          = 128
  memory       = 256
}
