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
#   role       = aws_iam_role.hello_world_task.id
#   policy_arn = aws_iam_policy.list_objects.arn
# }