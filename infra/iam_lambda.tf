# resource "aws_iam_role" "list_objects_lambda_function" {
#   name = "ListObjectsLambdaFunction"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# data "aws_iam_policy" "lambda_basic_execution_policy" {
#   name = "AWSLambdaBasicExecutionRole"
# }

# resource "aws_iam_policy" "list_objects" {
#   name = "ListObjectsInBucket${var.list_objects_bucket}"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid : "ListObjectsInBucket"
#         Action = [
#           "s3:ListBucket",
#         ]
#         Effect   = "Allow"
#         Resource = "arn:aws-us-gov:s3:::${var.list_objects_bucket}"
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "list_objects_lambda_function_basic_execution_policy" {
#   role       = aws_iam_role.list_objects_lambda_function.name
#   policy_arn = data.aws_iam_policy.lambda_basic_execution_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "list_objects_lambda_function_list_objects" {
#   role       = aws_iam_role.list_objects_lambda_function.name
#   policy_arn = aws_iam_policy.list_objects.arn
# }

# resource "aws_iam_role" "list_objects_lambda_function_codebuild" {
#   name = "ListObjectsLambdaFunctionCodeBuild"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "codebuild.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_policy" "list_objects_lambda_function_codebuild" {
#   name = "CodeBuildToCodeCommitS3AndLambda"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid : "GetCodeFromCodeCommitRepo"
#         Action = [
#           "codecommit:*",
#         ]
#         Effect   = "Allow"
#         Resource = aws_codecommit_repository.lambdas_source_code.arn
#       },
#       {
#         Sid : "CopyLambdaDeploymentPackageToS3"
#         Action = [
#           "s3:PutObject",
#         ]
#         Effect   = "Allow"
#         Resource = [aws_s3_bucket.utility_lambdas.arn, "${aws_s3_bucket.utility_lambdas.arn}/*"]
#       },
#       {
#         Sid : "UpdateLambdaFunction"
#         Action = [
#           "lambda:*",
#         ]
#         Effect   = "Allow"
#         Resource = aws_lambda_function.list_objects.arn
#       },
#       {
#         Sid : "WriteToCloudWatchLogs"
#         Action = [
#           "logs:*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "list_objects_lambda_function_codebuild" {
#   role       = aws_iam_role.list_objects_lambda_function_codebuild.name
#   policy_arn = aws_iam_policy.list_objects_lambda_function_codebuild.arn
# }

# https://www.lewuathe.com/how-to-add-new-policy-to-iam-role.html
# ^ how to work with roles, policies and policy attachments

# https://devops.stackexchange.com/a/5099
# ^ "The purpose of the AssumeRolePolicyDocument is to contain the trust relationship policy that grants an entity permission to assume the role." 
# in this example it's granting the lambda function the ability to assume the role

# https://docs.aws.amazon.com/lambda/latest/dg/lambda-permissions.html
# ^ lambda permissions documentation

# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html
# ^ IAM JSON policy elements reference

# https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/using-govcloud-arns.html
# ^ GovCloud ARNs are different

# https://stackoverflow.com/a/61440755
# For S3 permissions in a policy you need the bucket ARN and the bucket ARN with "/*" appended 
