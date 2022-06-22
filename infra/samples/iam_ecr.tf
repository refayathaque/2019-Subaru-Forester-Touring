# resource "aws_ecr_repository_policy" "hello_world" {
#   repository = aws_ecr_repository.hello_world.name
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid : "ECSTaskAccess"
#         Action = [
#           "ecr:GetAuthorizationToken",
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#         ]
#         Effect = "Allow",
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         },
#         Condition = {
#           ArnLike = {
#             "aws:SourceArn" = "arn:aws:ecs:us-east-1:920394549028:task-definition/hello-world:*"
#           }
#           # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html
#         }
#       },
#     ]
#   })
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy
# repository policy examples - https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-policy-examples.html
# thought I needed to set this up for ECS to be able to pull images from ECR, but I think the ECS task execution role provides sufficient permissions
