resource "aws_cloudwatch_log_group" "hello_world_task" {
  name = "hello-world-task"
  tags = {
    Environment = "dev"
    Application = "hello-world-microservice"
    Type        = "ECS task container log"
  }
}
