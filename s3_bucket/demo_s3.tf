resource "random_string" "suffix" {
  length = 6  
  special = false
  upper = false
}

resource "aws_s3_bucket" "s3" {
  bucket = "demo-${random_string.suffix.result}"

  tags = {
    Name = "Demo Bucket"
    Environment = "Dev"
  }
}