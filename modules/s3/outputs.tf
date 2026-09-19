output "bucket_id" {
  value = aws_s3_bucket.sbucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.sbucket.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.sbucket.bucket_regional_domain_name
}
