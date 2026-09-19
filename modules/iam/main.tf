data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.test_role.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.test_role.name
}

resource "aws_iam_policy" "s3_cloudfront_policy" {
  name        = "s3-cloudfront-access-policy"
  description = "IAM policy allowing read access to S3 for CloudFront distribution"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3Read"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "microservices_rds_policy" {
  name        = "microservices-rds-access-policy"
  description = "IAM policy allowing microservices to connect to RDS via IAM authentication"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowRDSConnect"
        Effect = "Allow"
        Action = [
          "rds-db:connect"
        ]
        Resource = [
          "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${var.rds_db_identifier}/${var.db_user}"
        ]
      }
    ]
  })
}
# Attach RDS policy to worker node role so pods on nodes can reach RDS
resource "aws_iam_role_policy_attachment" "attach_rds_policy" {
  policy_arn = aws_iam_policy.microservices_rds_policy.arn
  role       = aws_iam_role.test_role.name
}
