output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  value = [
    aws_subnet.my_subnet.id,
    aws_subnet.my_subnet_2.id
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_ig.id
}

output "nat_gateway" {
  value = aws_nat_gateway.mynat.id
}

output "route_table" {
  value = aws_route_table.myroutetable.id
}
