output "table_name" {
  value = aws_dynamodb_table.dtable.name
}

output "table_arn" {
  value = aws_dynamodb_table.dtable.arn
}
