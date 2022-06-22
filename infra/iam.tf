resource "aws_iam_role" "hello_world_task_execution" {
  name = "HelloWorldTaskExecution"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "hello_world_task_execution_ecs_task_execution_role_policy" {
  role       = aws_iam_role.hello_world_task_execution.name
  policy_arn = data.aws_iam_policy.ecs_task_execution_role_policy.arn
}

# resource "aws_iam_policy" "list_objects" {
#   name = "ListObjectsInBucket${var.list_objects_bucket}"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid = "ListObjectsInBucket"
#         Action = [
#           "s3:ListBucket"
#         ]
#         Effect   = "Allow"
#         Resource = "arn:aws-us-gov:s3:::${var.list_objects_bucket}"
#       },
#     ]
#   })
# }


# resource "aws_iam_role_policy_attachment" "hello_world_task_list_objects" {
#   role       = aws_iam_role.hello_world_task.name
#   policy_arn = aws_iam_policy.list_objects.arn
# }

# how to work with roles, policies and policy attachments - https://www.lewuathe.com/how-to-add-new-policy-to-iam-role.html

# "The purpose of the AssumeRolePolicyDocument is to contain the trust relationship policy that grants an entity permission to assume the role." - https://devops.stackexchange.com/a/5099
# ^ in this example it's granting the ECS service the ability to assume the role

# IAM JSON policy elements reference - https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html
# for S3 permissions in a policy you need the bucket ARN and the bucket ARN with "/*" appended - https://stackoverflow.com/a/61440755
