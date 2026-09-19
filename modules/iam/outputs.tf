output "role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.test_role.name
}

output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.test_role.arn
}

output "s3_cloudfront_policy_arn" {
  description = "ARN of the S3-CloudFront IAM policy"
  value       = aws_iam_policy.s3_cloudfront_policy.arn
}

output "microservices_rds_policy_arn" {
  description = "ARN of the Microservices-to-RDS IAM policy"
  value       = aws_iam_policy.microservices_rds_policy.arn
}
