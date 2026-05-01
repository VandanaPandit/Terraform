terraform {
  required_version = ">=1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.41.0"
    }
  }
  backend "s3" {
    bucket = "value"
    key = "value"
    region = "value"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}