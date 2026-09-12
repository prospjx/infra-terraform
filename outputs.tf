output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_subnets" {
  description = "The subnet IDs of the VPC"
  value       = module.vpc.subnet_ids
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = module.dynamodb.table_arn
}

output "eks_iam_role_arn" {
  description = "IAM role ARN for EKS"
  value       = module.eks.iam_role_arn
}
