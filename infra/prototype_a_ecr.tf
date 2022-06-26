resource "aws_ecr_repository" "hello_world" {
  name                 = "hello-world"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "aws_ecr_repository_hello_world_arn" {
  value = aws_ecr_repository.hello_world.arn
}

output "aws_ecr_repository_hello_world_registry_id" {
  value = aws_ecr_repository.hello_world.registry_id
}

output "aws_ecr_repository_hello_world_repository_url" {
  value = aws_ecr_repository.hello_world.repository_url
}
