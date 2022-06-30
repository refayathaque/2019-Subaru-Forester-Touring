terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
      # ^ latest version as of 6/9/22
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    }
  }
  required_version = "~> 1.2.2"
  # ^ terraform latest version as of 6/9/22
  # https://www.terraform.io/cli/commands/version
  # https://www.terraform.io/downloads
}

provider "aws" {
  region = var.region
}
