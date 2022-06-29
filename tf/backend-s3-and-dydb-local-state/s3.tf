resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-refayat"
  lifecycle {
    prevent_destroy = false
  }
  #   versioning {
  #     enabled = true
  #   }
  #   server_side_encryption_configuration {
  #     rule {
  #       apply_server_side_encryption_by_default {
  #         sse_algorithm = "AES256"
  #       }
  #     }
  #   }
  # YouTube video uses both of ^, but they're deprecated
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
