resource "aws_ecr_repository" "node_js" {
  name                 = "node-js"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "aws_ecr_repository_node_js_arn" {
  value = aws_ecr_repository.node_js.arn
}

output "aws_ecr_repository_node_js_registry_id" {
  value = aws_ecr_repository.node_js.registry_id
}

output "aws_ecr_repository_node_js_repository_url" {
  value = aws_ecr_repository.node_js.repository_url
}
