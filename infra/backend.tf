terraform {
  backend "s3" {
    bucket         = "terraform-state-refayat"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}

# how to set up a tf backend? watch this: https://www.youtube.com/watch?v=FTgvgKT09qM&t=877s
# the infrastructure required (s3 bucket and dynamodb table) for the backend was built separately, with the tf code for them and their tf state (local) on Refayat's laptop