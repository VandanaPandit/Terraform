output "s3_bucket_name" {
  value = "${aws_s3_bucket.s3.bucket}"
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.s3.id}"
}

output "s3_arn" {
  value = "${aws_s3_bucket.s3.arn}"
  description = "THIS IS ARN OF S3 BUCKET"
}