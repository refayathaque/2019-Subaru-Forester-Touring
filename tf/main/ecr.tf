resource "aws_ecr_repository" "hello_world" {
  name                 = "hello-world"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "prototype_b_container_a" {
  name                 = "container-a"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "prototype_b_container_b" {
  name                 = "container-b"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

# output "aws_ecr_repository_hello_world_arn" {
#   value = aws_ecr_repository.hello_world.arn
# }

# output "aws_ecr_repository_hello_world_registry_id" {
#   value = aws_ecr_repository.hello_world.registry_id
# }

output "aws_ecr_repository_prototype_b_container_a_url" {
  value = aws_ecr_repository.prototype_b_container_a.repository_url
}

output "aws_ecr_repository_prototype_b_container_b_url" {
  value = aws_ecr_repository.prototype_b_container_b.repository_url
}
