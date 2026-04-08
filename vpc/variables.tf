variable "aws_region" {
  type        = string
  description = "AWS region for deploying resources"
  default     = "us-east-1"
}

variable "environment_name" {
  description = "Environment name used in resource name and tags"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "global tag to apply for all resources"
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}

variable "subnet_newbits" {
  description = "number of new bits to add to VPC CIDR  to generate subnets means 8/ to 24 from /16"
  type        = number
  default     = 8
}