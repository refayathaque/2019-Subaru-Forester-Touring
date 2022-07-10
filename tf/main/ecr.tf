resource "aws_ecr_repository" "hello_world" {
  name                 = "hello-world"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "reads_from_dydb" {
  name                 = "reads-from-dydb"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

output "aws_ecr_repository_hello_world_repository_url" {
  value = aws_ecr_repository.hello_world.repository_url
}
# ^ need this when pushing images from local to ECR using Docker push command

output "aws_ecr_repository_reads_from_dydb_repository_url" {
  value = aws_ecr_repository.reads_from_dydb.repository_url
}
