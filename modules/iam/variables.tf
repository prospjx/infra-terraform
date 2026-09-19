variable "s3_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket"
  default     = "*"
}

variable "rds_db_identifier" {
  type        = string
  description = "Identifier of the RDS database"
  default     = "mydb"
}

variable "db_user" {
  type        = string
  description = "Database username for IAM authentication"
  default     = "admin"
}
