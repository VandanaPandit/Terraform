resource "random_string" "suffix" {
  length = 6  
  special = false
  upper = false
}

resource "aws_s3_bucket" "s3" {
  bucket = "demo-${random_string.suffix.result}"
  tags = merge(var.tags,{Name = "${var.environment_name}-s3"})
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "s3ver" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3Encrypt" {
  bucket = aws_s3_bucket.s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3BlockPub" {
  bucket = aws_s3_bucket.s3.id
  block_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}