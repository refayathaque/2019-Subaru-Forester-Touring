resource "aws_iam_role" "reads_from_dydb_task" {
  name = "ReadsFromDyDbTask"
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

resource "aws_iam_policy" "reads_from_dydb_task" {
  name = "reads_from_dydb"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DescribeTable",
          "dynamodb:ListTables"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "reads_from_dydb_task" {
  role       = aws_iam_role.reads_from_dydb_task
  policy_arn = aws_iam_policy.reads_from_dydb_task.arn
}
