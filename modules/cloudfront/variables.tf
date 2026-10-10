variable "s3_bucket_id" {
  type        = string
  description = "ID of the S3 bucket"
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket"
}

variable "s3_bucket_regional_domain_name" {
  type        = string
  description = "Regional domain name of the S3 bucket"
}

variable "backend_domain_name" {
  type        = string
  description = "Domain name for EKS Backend Load Balancer"
  default     = ""
}

