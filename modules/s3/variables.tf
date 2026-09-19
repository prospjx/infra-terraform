variable "bucket_name" {
  type    = string
  default = "scsdev-my-test-bucket-20260911"
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "The ARN of the CloudFront distribution to allow access"
  default     = "*"
}
