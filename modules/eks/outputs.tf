output "iam_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "iam_role_name" {
  value = aws_iam_role.cluster.name
}
