resource "aws_cloudwatch_log_group" "hello_world_container" {
  name = "hello-world-container"
}

resource "aws_cloudwatch_log_group" "reads_from_dydb_container" {
  name = "reads-from-dydb-container"
}
