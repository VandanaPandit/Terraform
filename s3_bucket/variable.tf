variable "region" {
    default = "us-east-1"
  }

variable "environment_name" {
  type = string
  description = "describe the resource belongs to env"
}

variable "tags" {
  type = map()
}